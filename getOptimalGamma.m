function [  gamma, P_tilde, T_tilde ] = getOptimalGamma( lambda, t_tilde, gamma, z, relay_idx )
%GETOPTIMALGAMMA Summary of this function goes here
%   Detailed explanation goes here
global threshold T_frame B S_num R_num;

epoch = 1;

gamma_old = gamma;
[ gamma, P_tilde_temp, T_tilde_temp, f_val] = SecondaryMaster_DualMultiplier_SubProblemsAll( lambda, t_tilde, gamma, z, relay_idx);

f_val_old = 1 + f_val;
while ((norm(gamma - gamma_old) > threshold) || (abs(f_val - f_val_old) > threshold)) && (epoch < 1000)
    gamma_old = gamma;
    f_val_old = f_val;
    [ gamma, P_tilde_temp, T_tilde_temp, f_val] = SecondaryMaster_DualMultiplier_SubProblemsAll( lambda, t_tilde, gamma, z, relay_idx);
%     f_val
%     fprintf('Gamma iteration, epoch %d\n',epoch);
    epoch = epoch + 1;
end
% for ii = 1:200
%     gamma_old = gamma;
%     [ gamma, P_tilde_temp, T_tilde_temp] = SecondaryMaster_DualMultiplier_SubProblemsAll( lambda, t_tilde, gamma, z, relay_idx);
% %     fprintf('Gamma iteration, epoch %d\n',epoch);
% %     epoch = epoch + 1;
% t_tilde - lambda * (sum(exp(T_tilde_temp(1:S_num))) + sum(exp(T_tilde_temp(S_num+1:S_num+R_num)) .* z(S_num+1:S_num+R_num)) - T_frame)...
%         -  sum(gamma(1:S_num).*(t_tilde + P_tilde_temp(1:S_num) + T_tilde_temp(1:S_num) - log(T_frame * B(1:S_num))))
% end


P_tilde = P_tilde_temp;
T_tilde = T_tilde_temp;


f_obj_dual = t_tilde - lambda * (sum(exp(T_tilde_temp(1:S_num))) + sum(exp(T_tilde_temp(S_num+1:S_num+R_num)) .* z(S_num+1:S_num+R_num)) - T_frame)...
        -  sum(gamma(1:S_num).*(t_tilde + P_tilde_temp(1:S_num) + T_tilde_temp(1:S_num) - log(T_frame * B(1:S_num))));
fprintf('The dual solution f*(t_tilde) is %f\n',f_obj_dual);
end

