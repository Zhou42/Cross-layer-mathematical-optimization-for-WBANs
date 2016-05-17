function [ gamma, P_tilde, T_tilde, f_val] = SecondaryMaster_DualMultiplier_SubProblemsAll( lambda, t_tilde, gamma, z, relay_idx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% this is d(gamma), the central version
% Once decision variable z is given, the problem is now a convex problem
% z is a vector of size (S_num + R_num) * 1
% gamma is a vector of size S_num * 1
% Input: lambda, t_tilde, gamma, z, relay_idx
% Output: updated gamma: gamma = [gamma + \alpha * (gradient)]^+

global S_num R_num B T_frame W N P_max P_min alpha_inBody x_s r_relay theta;

%% 
cvx_begin quiet
    variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
    maximize( t_tilde - lambda * (sum(exp(T_tilde_temp(1:S_num))) + sum(exp(T_tilde_temp(S_num+1:S_num+R_num)) .* z(S_num+1:S_num+R_num)) - T_frame )...
        -  sum(gamma(1:S_num).*(t_tilde + P_tilde_temp(1:S_num) + T_tilde_temp(1:S_num) - log(T_frame * B(1:S_num)))));
    subject to
%         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
        % Region 1
        T_tilde_temp(1:3) + log(W * log_sci((alpha_inBody(1:3,relay_idx(1)).*exp(P_tilde_temp(1:3)))/N(relay_idx(1)))) >= log(x_s(1:3) * T_frame)
        % Region 2
        T_tilde_temp(4:6) + log(W * log_sci((alpha_inBody(4:6,relay_idx(2)).*exp(P_tilde_temp(4:6)))/N(relay_idx(2)))) >= log(x_s(4:6) * T_frame)
        % Region 3
        T_tilde_temp(7:9) + log(W * log_sci((alpha_inBody(7:9,relay_idx(3)).*exp(P_tilde_temp(7:9)))/N(relay_idx(3)))) >= log(x_s(7:9) * T_frame)
        % Region 4
        T_tilde_temp(10:12) + log(W * log_sci((alpha_inBody(10:12,relay_idx(4)).*exp(P_tilde_temp(10:12)))/N(relay_idx(4)))) >= log(x_s(10:12) * T_frame)
        % Region 5
        T_tilde_temp(13:17) + log(W * log_sci((alpha_inBody(13:17,relay_idx(5)).*exp(P_tilde_temp(13:17)))/N(relay_idx(5)))) >= log(x_s(13:17) * T_frame)
        
        % Region 1
        log(r_relay(relay_idx(1)) * exp(T_tilde_temp(relay_idx(1)))) >= log(sum(x_s(1:3) * T_frame))
        % Region 2
        log(r_relay(relay_idx(2)) * exp(T_tilde_temp(relay_idx(2)))) >= log(sum(x_s(4:6) * T_frame))
        % Region 3
        log(r_relay(relay_idx(3)) * exp(T_tilde_temp(relay_idx(3)))) >= log(sum(x_s(7:9) * T_frame))
        % Region 4
        log(r_relay(relay_idx(4)) * exp(T_tilde_temp(relay_idx(4)))) >= log(sum(x_s(10:12) * T_frame))
        % Region 5
        log(r_relay(relay_idx(5)) * exp(T_tilde_temp(relay_idx(5)))) >= log(sum(x_s(13:17) * T_frame))
        
        log(P_min) <= P_tilde_temp(1:S_num) <= log(P_max)
cvx_end


P_tilde = P_tilde_temp;
T_tilde = T_tilde_temp;

gamma = gamma + theta * (t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num)- log(T_frame * B(1:S_num)));
gamma = max(gamma, 0);

f_val = t_tilde - lambda * (sum(exp(T_tilde_temp(1:S_num))) + sum(exp(T_tilde_temp(S_num+1:S_num+R_num)) .* z(S_num+1:S_num+R_num)) - T_frame)...
        -  sum(gamma(1:S_num).*(t_tilde + P_tilde_temp(1:S_num) + T_tilde_temp(1:S_num) - log(T_frame * B(1:S_num))));


end

