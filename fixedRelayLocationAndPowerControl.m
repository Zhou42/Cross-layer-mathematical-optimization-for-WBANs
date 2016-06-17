%% Result comparison with no relay locaiton control and with power control
% [1] Energy efficiency optimization by resource allocation in wireless body area networks
% 2016-05-04 by Yang Zhou
% There are only 17 implanted sensors, 5 relays and one coordinator in the WBSN. 

clc;
clear all;
close all;
cvx_solver Mosek
%% parameters
global S_num R_num C_num theta B T_frame W N P_max P_min alpha_inBody alpha_onBody x_s r_relay threshold buf_length F;
S_num = 17;
R_num = 40;
C_num = 1;
theta = 1e-2;
threshold = 1e-4;
% Battery level - relay has twice the energy of the sensor nodes
B = ones(S_num,1); % J
% Check the influence!!
T_frame = 0.4; % s
% only use one channel [3]
W = 3e5; % Hz
N = (10^(-17.4)*W) * ones(S_num + R_num + 1,1) /1000; % -174dBm/Hz [1]; Unit is W
P_max = 10^(0/10) / 1000; % W
% For test
P_min = 10^(-15/10) / 1000;
% P_min = 10^(-28/10) / 1000;n 

% coordinate
% im = imread('WBSNGraph.jpg');
% imshow(im);
x_body = 1137:170:1650;
y_body = [897 1075 1259 1464 1681];
[x_grid, y_grid] = meshgrid(x_body, y_body);

X = [
 114 913;
 359 841;
 491 1007;  % left arm - region 1
 2607 914;
 2364 841;
 2176 1004;  % right arm - region 2
 1199 2057;
 1054 2245;
 1050 2561;  % left leg - region 3
 1575 2036;
 1724 2228;
 1728 2578;  % right leg - region 4
 1387 312;  % head - region 5
 1594 1010;
 1387 1170;
 1502 1383;
 1111 1561;  % torso - region 6
           % sensors
 [235:170:750]' 916*ones(4,1); % Relay CS: left arm - 4 nodes
 [1923:170:2440]' 916*ones(4,1); % Relay CS: right arm - 4 nodes
 1120*ones(5,1) [1934:190:2740]'; % Relay CS: left leg - 4 nodes
 1642*ones(5,1) [1934:190:2740]'; % Relay CS: right leg - 4 nodes
 
 1145 427;
 1643 427; % Relay CS: head - 2 nodes
 
 reshape(x_grid,[20 1]) reshape(y_grid,[20 1]); % Relay CS: torso - 20 nodes
 1647 1592 % coordinator
];

%% Graph
% imshow(im);
% 
% % hold on;
% % scatter(X(:,1),X(:,2));
% % set(gca,'ydir','reverse','xaxislocation','top');
% 

% for i = 1:(S_num + R_num + 1)
%     text(X(i,1) ,X(i,2),num2str(i));
% end


% distance matrix; the image is 1022*1045 pixels
% !! This distance matrix needs to be updated to 3D-distance version!!
fac = 1500;
d = squareform(pdist(X)); % each row of X is (x_i,y_i)
D_inBody = d/fac; % transform unit from pixels into meters
D_onBody = d/fac;

% In-body Pathloss model for sensors [2]; for sensor 1~17 to relay CS 18~55
d_0_inBody = 0.05; % m
n_inBody = 4.26;
PL_0_inBody = 47.14; % dB
PL_inBody = PL_0_inBody + 10 * n_inBody * log(D_inBody/d_0_inBody)/log(10); % dB
for i = 1:S_num + R_num + 1
    PL_inBody(i, i) = 0;
end
alpha_inBody = 10.^( - PL_inBody./10);


% On-body Pathloss model for relays; relay CS 18~55 to coordinator
d_0_onBody = 0.1;
n_onBody  = 3.11;
PL_0_onBody = 35.2;
PL_onBody = PL_0_onBody + 10 * n_onBody * (log(D_onBody/d_0_onBody)/log(10));
for i = 1:S_num + R_num + 1
    PL_onBody(i, i) = 0;
end
alpha_onBody = 10.^( - PL_onBody./10);

% x_s - 50kbps for each node
% x_s = 50000 * ones(S_num,1) * 2.5; % bit/s - 100 kb seems to be proper for lambda to converge to a positive number
x_s = 45000 * ones(S_num,1);
% data rate of relay to coordinator
r_relay(S_num + 1:S_num + R_num) = W * log_sci(1 + (alpha_onBody(S_num + 1:S_num + R_num, S_num + R_num + 1).*P_max)/N(S_num + R_num + 1)); % bit/s


%% z is known, the problem is convex 
relay_idx = [19 22 29 34 36 53];
z = zeros(S_num + R_num, 1);
z(relay_idx) = 1;

cvx_begin
    variables T_tilde(S_num + R_num,1) P_tilde(S_num + R_num,1) t_tilde;
    maximize(t_tilde);
    subject to
        t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) <= log(T_frame * B(1:S_num))
        sum(exp(T_tilde(1:S_num))) + sum(exp(T_tilde(relay_idx))) <= T_frame
        % left arm
%         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
        T_tilde(1:3) + log(W * log_sci((alpha_inBody(1:3,relay_idx(1)).*exp(P_tilde(1:3)))/N(relay_idx(1)))) >= log(x_s(1:3) * T_frame)
        % right arm
        T_tilde(4:6) + log(W * log_sci((alpha_inBody(4:6,relay_idx(2)).*exp(P_tilde(4:6)))/N(relay_idx(2)))) >= log(x_s(4:6) * T_frame)
        % left leg
        T_tilde(7:9) + log(W * log_sci((alpha_inBody(7:9,relay_idx(3)).*exp(P_tilde(7:9)))/N(relay_idx(3)))) >= log(x_s(7:9) * T_frame)
        % right leg
        T_tilde(10:12) + log(W * log_sci((alpha_inBody(10:12,relay_idx(4)).*exp(P_tilde(10:12)))/N(relay_idx(4)))) >= log(x_s(10:12) * T_frame)
        % head
        T_tilde(13) + log(W * log_sci((alpha_inBody(13,relay_idx(5)).*exp(P_tilde(13)))/N(relay_idx(5)))) >= log(x_s(13) * T_frame)
        % Torso
        T_tilde(14:17) + log(W * log_sci((alpha_inBody(14:17,relay_idx(6)).*exp(P_tilde(14:17)))/N(relay_idx(6)))) >= log(x_s(14:17) * T_frame)
        
        % Region 1
        log(r_relay(relay_idx(1)) * exp(T_tilde(relay_idx(1)))) >= log(sum(x_s(1:3) * T_frame))
        % Region 2
        log(r_relay(relay_idx(2)) * exp(T_tilde(relay_idx(2)))) >= log(sum(x_s(4:6) * T_frame))
        % Region 3
        log(r_relay(relay_idx(3)) * exp(T_tilde(relay_idx(3)))) >= log(sum(x_s(7:9) * T_frame))
        % Region 4
        log(r_relay(relay_idx(4)) * exp(T_tilde(relay_idx(4)))) >= log(sum(x_s(10:12) * T_frame))
        % Region 5
        log(r_relay(relay_idx(5)) * exp(T_tilde(relay_idx(5)))) >= log(sum(x_s(13) * T_frame))
        % Region 6
        log(r_relay(relay_idx(6)) * exp(T_tilde(relay_idx(6)))) >= log(sum(x_s(14:17) * T_frame))
        
        log(P_min) <= P_tilde(1:S_num) <= log(P_max)
cvx_end
save('./DualityGap/Multihop_FixedRelayLocation_Results_45kbps_400ms.mat');