function [ gamma ] = getOptimalGamma_KKT( lambda, t_tilde, T_tilde, P_tilde, z, relay_idx )
%GETOPTIMALGAMMA Summary of this function goes here
%   Detailed explanation goes here
% T_tilde is of size 1*36
% P_tilde is of size 1*17
% B is of size 17*1
global T_frame B S_num R_num x_s alpha_inBody N P_max alpha_onBody W P_min;

% map from sensor i to its relay j
relayMapping = [relay_idx(1) * ones(3,1); relay_idx(2) * ones(3,1); relay_idx(3) * ones(3,1); relay_idx(4) * ones(3,1); relay_idx(5); relay_idx(6) * ones(4,1)];

%% Complementary slackness matrix
D_vec_1 = t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) - log(T_frame * B(1:S_num));
for i = 1:S_num
    D_vec_2(i) = log(x_s(i) * T_frame) - (T_tilde(i) + log(W * log_sci(alpha_inBody(i,relayMapping(i))*exp(P_tilde(i))/N(relayMapping(i)))));
end
D_vec_2 = D_vec_2';

D_vec_3(1) = log(sum(x_s(1:3) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(1),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(1))));
D_vec_3(2) = log(sum(x_s(4:6) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(4),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(4))));
D_vec_3(3) = log(sum(x_s(7:9) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(7),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(7))));
D_vec_3(4) = log(sum(x_s(10:12) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(10),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(10))));
D_vec_3(5) = log(sum(x_s(13) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(13),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(13))));
D_vec_3(6) = log(sum(x_s(14:17) * T_frame)) - log(W * log_sci(alpha_onBody(relayMapping(14),S_num + R_num + 1)*P_max/N(S_num + R_num + 1))* exp(T_tilde(relayMapping(14))));
D_vec_3 = D_vec_3';

D_vec_4 = P_tilde(1:S_num) - log(P_max);
D_vec_5 = log(P_min) - P_tilde(1:S_num);

D = diag([D_vec_1; D_vec_2; D_vec_3; D_vec_4; D_vec_5]);
%% Derivative of L over P
Dp_temp(1:3) = log_sci(exp(1))./(log_sci(alpha_inBody(1:3,relayMapping(1))/N(relayMapping(1))) + P_tilde(1:3)*log_sci(exp(1)));
Dp_temp(4:6) = log_sci(exp(1))./(log_sci(alpha_inBody(4:6,relayMapping(4))/N(relayMapping(4))) + P_tilde(4:6)*log_sci(exp(1)));
Dp_temp(7:9) = log_sci(exp(1))./(log_sci(alpha_inBody(7:9,relayMapping(7))/N(relayMapping(7))) + P_tilde(7:9)*log_sci(exp(1)));
Dp_temp(10:12) = log_sci(exp(1))./(log_sci(alpha_inBody(10:12,relayMapping(10))/N(relayMapping(10))) + P_tilde(10:12)*log_sci(exp(1)));
Dp_temp(13) = log_sci(exp(1))./(log_sci(alpha_inBody(13,relayMapping(13))/N(relayMapping(13))) + P_tilde(13)*log_sci(exp(1)));
Dp_temp(14:17) = log_sci(exp(1))./(log_sci(alpha_inBody(14:17,relayMapping(14))/N(relayMapping(14))) + P_tilde(14:17)*log_sci(exp(1)));


Dp = [diag(-ones(S_num,1)) diag(Dp_temp) zeros(S_num,6) diag(-ones(S_num,1)) diag(ones(S_num,1))];
%% Dt_i
Dt_i = [diag(-ones(S_num,1)) diag(ones(S_num,1)) zeros(S_num,6 + 2 * S_num)];

%% Dt_j
Dt_j = [zeros(6, 2 * S_num) diag(ones(6,1)) zeros(6, 2 * S_num)];

%%
[hh_1, ww] = size(D);
[hh_2, ww] = size(Dp);
[hh_3, ww] = size(Dt_i);
[hh_4, ww] = size(Dt_j);


A = [D;Dp;Dt_i;Dt_j];
b = [zeros(hh_1,1);zeros(hh_2,1);lambda*exp(T_tilde(1:S_num));lambda*exp(T_tilde(relay_idx))];
f = zeros(ww,1);

%% solve Ax = b, x >= 0
% x = linprog(f,[],[],A,b,zeros(ww,1),[]); % equality constraint is strict? Cannot be satisfied
% Instead, consider min. ||Ax - b||2, s.t. x>= 0
% <=> min. (1/2)x'A'Ax - b'Ax, s.t. x >= 0
H = A'* A;
f = - A' * b;
opts = optimset('Display','off');
x = quadprog(H,f,[],[],[],[],zeros(ww,1),[],[],opts);

gamma = x(1:S_num);

% f_obj_dual = t_tilde - lambda * (sum(exp(T_tilde(1:S_num))) + sum(exp(T_tilde(S_num+1:S_num+R_num)) .* z(S_num+1:S_num+R_num)) - T_frame)...
%         -  sum(gamma(1:S_num).*(t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) - log(T_frame * B(1:S_num))));
% fprintf('The dual solution f*(t_tilde) is %f\n',f_obj_dual);
end

