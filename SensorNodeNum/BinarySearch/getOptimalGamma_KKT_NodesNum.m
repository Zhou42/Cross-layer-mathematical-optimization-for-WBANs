function [ gamma ] = getOptimalGamma_KKT_NodesNum( lambda, t_tilde, T_tilde, P_tilde, z, relay_idx, sensor_flag )
%GETOPTIMALGAMMA Summary of this function goes here
%   Detailed explanation goes here
% T_tilde is of size 1*36
% P_tilde is of size 1*17
% B is of size 17*1
global T_frame B S_num R_num x_s alpha_inBody N P_max alpha_onBody W P_min;

sensor_idx = find(sensor_flag == 1);

% map from sensor i to its relay j
relayMapping = [relay_idx(1) * ones(3,1); relay_idx(2) * ones(3,1); relay_idx(3) * ones(3,1); relay_idx(4) * ones(3,1); relay_idx(5); relay_idx(6) * ones(4,1)];

%% Complementary slackness matrix
% The missing sensors are removed!!
D_vec_1 = t_tilde + P_tilde(sensor_idx) + T_tilde(sensor_idx) - log(T_frame * B(sensor_idx));
for i = 1:S_num
    D_vec_2(i) = log(x_s(i) * T_frame) - (T_tilde(i) + log(W * log_sci(alpha_inBody(i,relayMapping(i))*exp(P_tilde(i))/N(relayMapping(i)))));
end
D_vec_2 = D_vec_2(sensor_idx)';

D_vec_3(1) = log(sum(sensor_flag(1:3) .* x_s(1:3) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(1),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(1))));
D_vec_3(2) = log(sum(sensor_flag(4:6) .* x_s(4:6) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(4),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(4))));
D_vec_3(3) = log(sum(sensor_flag(7:9) .* x_s(7:9) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(7),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(7))));
D_vec_3(4) = log(sum(sensor_flag(10:12) .* x_s(10:12) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(10),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(10))));
D_vec_3(5) = log(sum(sensor_flag(13) .* x_s(13) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(13),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(13))));
D_vec_3(6) = log(sum(sensor_flag(14:17) .* x_s(14:17) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(14),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(14))));
D_vec_3 = D_vec_3';

D_vec_4 = P_tilde(sensor_idx) - log(P_max);
D_vec_5 = log(P_min) - P_tilde(sensor_idx);

D = diag([D_vec_1; D_vec_2; D_vec_3; D_vec_4; D_vec_5]);
%% Derivative of L over P
sensor_idx_1 = sensor_idx((sensor_idx>=1) & (sensor_idx<=3));
sensor_idx_2 = sensor_idx((sensor_idx>=4) & (sensor_idx<=6));
sensor_idx_3 = sensor_idx((sensor_idx>=7) & (sensor_idx<=9));
sensor_idx_4 = sensor_idx((sensor_idx>=10) & (sensor_idx<=12));
sensor_idx_5 = sensor_idx((sensor_idx>=13) & (sensor_idx<=13));
sensor_idx_6 = sensor_idx((sensor_idx>=14) & (sensor_idx<=17));
len1 = length(sensor_idx_1); % sensors in each region
len2 = length(sensor_idx_2);
len3 = length(sensor_idx_3);
len4 = length(sensor_idx_4);
len5 = length(sensor_idx_5);
len6 = length(sensor_idx_6);

start_1 = 1;
start_2 = start_1 + len1;
start_3 = start_2 + len2;
start_4 = start_3 + len3;
start_5 = start_4 + len4;
start_6 = start_5 + len5;

Dp_temp(start_1:(start_2-1)) = log_sci(exp(1))./(log_sci(alpha_inBody(sensor_idx_1,relayMapping(1))/N(relayMapping(1))) + P_tilde(sensor_idx_1)*log_sci(exp(1)));
Dp_temp(start_2:(start_3-1)) = log_sci(exp(1))./(log_sci(alpha_inBody(sensor_idx_2,relayMapping(4))/N(relayMapping(4))) + P_tilde(sensor_idx_2)*log_sci(exp(1)));
Dp_temp(start_3:(start_4-1)) = log_sci(exp(1))./(log_sci(alpha_inBody(sensor_idx_3,relayMapping(7))/N(relayMapping(7))) + P_tilde(sensor_idx_3)*log_sci(exp(1)));
Dp_temp(start_4:(start_5-1)) = log_sci(exp(1))./(log_sci(alpha_inBody(sensor_idx_4,relayMapping(10))/N(relayMapping(10))) + P_tilde(sensor_idx_4)*log_sci(exp(1)));
Dp_temp(start_5:(start_6-1)) = log_sci(exp(1))./(log_sci(alpha_inBody(sensor_idx_5,relayMapping(13))/N(relayMapping(13))) + P_tilde(sensor_idx_5)*log_sci(exp(1)));
Dp_temp(start_6:(start_6+len6-1)) = log_sci(exp(1))./(log_sci(alpha_inBody(sensor_idx_6,relayMapping(14))/N(relayMapping(14))) + P_tilde(sensor_idx_6)*log_sci(exp(1)));


Dp = [diag(-ones(length(sensor_idx),1)) diag(Dp_temp) zeros(length(sensor_idx),6) diag(-ones(length(sensor_idx),1)) diag(ones(length(sensor_idx),1))];
%% Dt_i
Dt_i = [diag(-ones(length(sensor_idx),1)) diag(ones(length(sensor_idx),1)) zeros(length(sensor_idx),6 + 2 * length(sensor_idx))];

%% Dt_j
Dt_j = [zeros(6, 2 * length(sensor_idx)) diag(ones(6,1)) zeros(6, 2 * length(sensor_idx))];

%%
[hh_1, ww] = size(D);
[hh_2, ww] = size(Dp);
[hh_3, ww] = size(Dt_i);
[hh_4, ww] = size(Dt_j);


A = [D;Dp;Dt_i;Dt_j];
b = [zeros(hh_1,1);zeros(hh_2,1);lambda*exp(T_tilde(sensor_idx));lambda*exp(T_tilde(relay_idx))];
f = zeros(ww,1);

%% solve Ax = b, x >= 0
% x = linprog(f,[],[],A,b,zeros(ww,1),[]); % equality constraint is strict? Cannot be satisfied
% Instead, consider min. ||Ax - b||2, s.t. x>= 0
% <=> min. (1/2)x'A'Ax - b'Ax, s.t. x >= 0
H = A'* A;
f = - A' * b;
opts = optimset('Display','off');
x = quadprog(H,f,[],[],[],[],zeros(ww,1),[],[],opts);

gamma = x(1:length(sensor_idx));

% f_obj_dual = t_tilde - lambda * (sum(exp(T_tilde(1:S_num))) + sum(exp(T_tilde(S_num+1:S_num+R_num)) .* z(S_num+1:S_num+R_num)) - T_frame)...
%         -  sum(gamma(1:S_num).*(t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) - log(T_frame * B(1:S_num))));
% fprintf('The dual solution f*(t_tilde) is %f\n',f_obj_dual);
end

