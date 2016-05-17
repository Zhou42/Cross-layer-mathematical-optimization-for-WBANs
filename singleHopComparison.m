%% Result comparison with single hop star topology
% [1] Energy efficiency optimization by resource allocation in wireless body area networks
% 2016-05-04 by Yang Zhou
% There are only 17 implanted sensors and one coordinator in the WBSN. Each
% sensor transmit to the coordinator directly

clc;
clear all;
close all;
cvx_solver Mosek

%% parameters
S_num = 17;
R_num = 38;
B = ones(S_num,1); % J
T_frame = 0.4; % s
W = 3e6; % Hz
N = (10^(-17.4)*W) * ones(S_num + R_num + 1,1) /1000; % -174dBm/Hz [1]; Unit is W
P_max = 10^(0/10) / 1000; % W
P_min = 10^(-28/10) / 1000;

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

d = squareform(pdist(X)); % each row of X is (x_i,y_i)
D_inBody = d/470; % transform unit from pixels into meters

% In-body Pathloss model for sensors [2]; for sensor 1~17 to relay CS 18~55
d_0_inBody = 0.05; % m
n_inBody = 4.26;
PL_0_inBody = 47.14; % dB
PL_inBody = PL_0_inBody + 10 * n_inBody * log(D_inBody/d_0_inBody)/log(10); % dB
for i = 1:S_num + R_num + 1
    PL_inBody(i, i) = 0;
end
alpha_inBody = 10.^( - PL_inBody./10);

% x_s - 50kbps for each node
x_s = 50000 * ones(S_num,1); % bit/s

cvx_begin
    variables T_tilde(S_num,1) P_tilde(S_num,1) t_tilde;
    maximize(t_tilde);
    subject to
        t_tilde + T_tilde + P_tilde <= log(B * T_frame)
        sum(exp(T_tilde)) <= T_frame
        T_tilde + log(W * log_sci((alpha_inBody(1:S_num, 56).*exp(P_tilde))/N(56))) >= log(x_s)
        % T_tilde + log(W * log_sci(1 + (alpha_inBody(1:S_num, 56).*exp(P_tilde))/N(56))) >= log(x_s)
        log(P_min) <= P_tilde <= log(P_max)
cvx_end



