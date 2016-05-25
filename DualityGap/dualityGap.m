%% Check the duality gap
load('../Results_100kbps.mat');

f_dual_optimal = t_tilde - lambda * (sum(exp(T_tilde(1:S_num))) + ...
    sum(exp(T_tilde(S_num + 1: S_num + R_num)) .* z(S_num + 1: S_num + R_num)) - T_frame);

sum(exp(T_tilde(1:S_num))) + ...
    sum(exp(T_tilde(S_num + 1: S_num + R_num)) .* z(S_num + 1: S_num + R_num)) - T_frame


% [t_tilde_pri, P_tilde_pri, T_tilde_pri] = primalOptimalGivenZ(find(z == 1));
% f_dual_optimal_2 = t_tilde_pri - lambda * (sum(exp(T_tilde_pri(1:S_num))) + ...
%     sum(exp(T_tilde_pri(S_num + 1: S_num + R_num)) .* z(S_num + 1: S_num + R_num)) - T_frame);

f_dual_optimal
% t_tilde

load('Primal_Results_100kbps_400ms.mat','t_tilde_opt');
f_primal_optimal = t_tilde_opt

