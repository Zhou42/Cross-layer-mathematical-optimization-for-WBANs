% 2016-05-23 by Yang Zhou
% [1] Energy Efficiency Optimziation by Resource Allocation in Wireless Body Area Networks
% Description: 
% [2] Channel Models for Medical Implant Communication. 
% Channel model - Table 1: Deep tissue implant to body surface
%
% According to the simulation result from topology part, we can conclude  
% there are 17 sensor nodes, 38 relay Candidate Sites and 1 coordinator

% Power unit in this file is: W
% Time unit: second
% So energy should be: J

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
    822 1618;
    750 1374;
    914 1246;  % left arm - region 1
    1950 1582;
    2030 1338;
    1858 1150; % right arm - region 2
    1074 2050;
    802 2234;
    610 2558;  % left leg - region 3
    1694 2026;
    1958 2226;
    2170 2566; % right leg - region 4
    1387 312;  % head - region 5
    1594 1010;
    1387 1170;
    1502 1383;
    1111 1561;  % torso - region 6
           % sensors
    822 * ones(4,1) [1490:-170:975]'; % Relay CS: left arm - 4 nodes
    1950 * ones(4,1) [894:170:1450]'; % Relay CS: right arm - 4 nodes
    1046 1934;
    942 2110;
    838 2298;
    714 2502;
    594 2718; % Relay CS: left leg - 4 nodes
    1706 1930;
    1814 2110;
    1918 2302;
    2034 2498;
    2158 2718; % Relay CS: right leg - 4 nodes
    
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

%% Exhaustive search for the optimal solution of the PRIMAL Problem
t_tilde_opt = -inf;
Round = 1;
tic
for i_1 = 18:21
    for i_2 = 22:25
        for i_3 = 26:30
            for i_4 = 31:35
                for i_5 = 36:37
                    for i_6 = 38:57
                        % z is known, the problem is convex 
                        relay_idx = [i_1 i_2 i_3 i_4 i_5 i_6];
                        z = zeros(S_num + R_num, 1);
                        z(relay_idx) = 1;
                        [t_tilde, T_tilde] = primalOptimalGivenZWithFixedPower(relay_idx);   
                        if t_tilde_opt < t_tilde
                            t_tilde_opt = t_tilde;
                            T_tilde_opt = T_tilde;
                            z_opt = z;
                        end
                        fprintf('Round %d/16000, the optimal t_tilde is %f\n', Round,t_tilde_opt);
                        Round = Round + 1;
                    end
                end
            end
        end
    end
end
toc

save('relayLocationControlAndFixedPower_Results_45kbps_400ms_position-3.mat');
