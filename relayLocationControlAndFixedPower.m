%% Result comparison with relay locaiton control and without power control
% [1] Energy efficiency optimization by resource allocation in wireless body area networks
% 2016-05-04 by Yang Zhou
% There are only 17 implanted sensors, 5 relays and one coordinator in the WBSN. 

clc;
clear all;
close all;
cvx_solver Mosek
%% parameters
S_num = 17;
R_num = 38;
C_num = 1;
theta = 1e-2;
threshold = 1e-4;
% Battery level - relay has twice the energy of the sensor nodes
B = ones(S_num,1); % J
T_frame = 0.4; % s
W = 3e6; % Hz
N = (10^(-17.4)*W) * ones(S_num + R_num + 1,1) /1000; % -174dBm/Hz [1]; Unit is W
P_max = 10^(0/10) / 1000; % W
P_min = 10^(-28/10) / 1000;

%% fixed transmission power
P = -15 * ones(S_num, 1); % dBmW
P_W = 10.^(P/10) / 1000; % W
P_tilde = log(P_W);

% coordinator
x_body = 415:57:590;
y_body = 356:65:630;
[x_grid, y_grid] = meshgrid(x_body, y_body);

X = [
 73 364;
 154 338;
 154 388;  % left arm
 905 363;
 824 338;
 824 388;  % right arm
 436 764;
 412 826;
 380 889;  % left leg
 554 764;
 587 827;
 618 889;  % right leg
 499 163;
 568 395;
 499 451;
 530 539;
 406 579;  % head & body
           % sensors
 [113:57:290]' 363*ones(4,1); % Relay CS: left arm - 4 nodes
 [677:57:860]' 363*ones(4,1); % Relay CS: right arm - 4 nodes
 409*ones(5,1) [705:65:980]'; % Relay CS: left leg - 4 nodes
 583*ones(5,1) [705:65:980]'; % Relay CS: right leg - 4 nodes
 reshape(x_grid,[20 1]) reshape(y_grid,[20 1]); % - 20 nodes
 584 590
];

% distance matrix; the image is 1022*1045 pixels
% !! This distance matrix needs to be updated to 3D-distance version!!
d = squareform(pdist(X)); % each row of X is (x_i,y_i)
D_inBody = d/470; % transform unit from pixels into meters
D_onBody = d/470;

% In-body Pathloss model for sensors [2]; for sensor 1~17 to relay CS 18~55
d_0_inBody = 0.05; % m
n_inBody = 4.26;
PL_0_inBody = 47.14; % dB
PL_inBody = PL_0_inBody + 10 * n_inBody * log(D_inBody/d_0_inBody)/log(10); % dB
for i = 1:S_num + R_num + 1
    PL_inBody(i, i) = 0;
end
alpha_inBody = 10.^( - PL_inBody./10);
r_ij(1:S_num,(S_num + 1):(S_num + R_num)) = W * log_sci(1 + (alpha_inBody(1:S_num,(S_num + 1):(S_num + R_num)).*repmat(P_W,1,R_num))./repmat(N((S_num + 1):(S_num + R_num))',S_num,1));

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
x_s = 50000 * ones(S_num,1); % bit/s

% data rate of relay to coordinator
r_jc((S_num + 1):(S_num + R_num)) = W * log_sci(1 + (alpha_onBody(S_num + 1:S_num + R_num,56).*P_max)/N(56)); % bit/s


%% 


cvx_begin
    variables T_tilde(S_num + R_num,1) t_tilde;
    variable z(S_num + R_num, 1) binary;
    maximize(t_tilde);
    subject to
        t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) <= log(T_frame * B(1:S_num))
        sum(exp(T_tilde(1:S_num))) + sum(exp(T_tilde((S_num + 1):(S_num + R_num))) .* z((S_num + 1):(S_num + R_num))) <= T_frame
        % left arm
%         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
        T_tilde(1:3) + log(r_ij(1:3, 18:21) * z(18:21)) >= log(x_s(1:3) * T_frame)
        % right arm
        T_tilde(4:6) + log(r_ij(4:6, 22:25) * z(22:25)) >= log(x_s(4:6) * T_frame)
        % left leg
        T_tilde(7:9) + log(r_ij(7:9, 26:30) * z(26:30)) >= log(x_s(7:9) * T_frame)
        % right leg
        T_tilde(10:12) +  log(r_ij(10:12, 31:35) * z(31:35)) >= log(x_s(10:12) * T_frame)
        % body
        T_tilde(13:17) +  log(r_ij(13:17, 36:55) * z(36:55)) >= log(x_s(13:17) * T_frame)
        
        % Region 1
        log(sum(r_jc(18:21).*exp(T_tilde(18:21)).*z(18:21))) >= log(sum(x_s(1:3) * T_frame))
        % Region 2
        log(sum(r_jc(22:25).*exp(T_tilde(22:25)).*z(22:25))) >= log(sum(x_s(4:6) * T_frame))
        % Region 3
        log(sum(r_jc(26:30).*exp(T_tilde(26:30)).*z(26:30))) >= log(sum(x_s(7:9) * T_frame))
        % Region 4
        log(sum(r_jc(31:35).*exp(T_tilde(31:35)).*z(31:35))) >= log(sum(x_s(10:12) * T_frame))
        % Region 5
        log(sum(r_jc(36:55).*exp(T_tilde(36:55)).*z(36:55))) >= log(sum(x_s(13:17) * T_frame))
        
        % Region 1
        sum(z(18:21)) = 1;
        % Region 2
        sum(z(22:25)) = 1;
        % Region 3
        sum(z(26:30)) = 1;
        % Region 4
        sum(z(31:35)) = 1;
        % Region 5
        sum(z(36:55)) = 1;
cvx_end
