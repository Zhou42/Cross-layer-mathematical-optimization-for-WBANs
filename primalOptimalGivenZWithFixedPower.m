function [ t_tilde, T_tilde ] = primalOptimalGivenZWithFixedPower( relay_idx )
%PRIMALOPTIMALGIVENZ Summary of this function goes here
%   Detailed explanation goes here
global S_num R_num C_num B T_frame W N P_max P_min alpha_inBody x_s r_relay;

P = -10 * ones(S_num, 1); % dBmW
P_W = 10.^(P/10) / 1000; % W
P_tilde = log(P_W);

cvx_expert true
cvx_begin quiet
    variables T_tilde(S_num + R_num,1) t_tilde;
    maximize(t_tilde);
    subject to
        t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) <= log(T_frame * B(1:S_num))
        sum(exp(T_tilde(1:S_num))) + sum(exp(T_tilde(relay_idx))) <= T_frame
        % left arm
%         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
        T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,relay_idx(1)).*exp(P_tilde(1:3)))/N(relay_idx(1)))) >= log(x_s(1:3) * T_frame)
        % right arm
        T_tilde(4:6) + log(W * log_sci(1 + (alpha_inBody(4:6,relay_idx(2)).*exp(P_tilde(4:6)))/N(relay_idx(2)))) >= log(x_s(4:6) * T_frame)
        % left leg
        T_tilde(7:9) + log(W * log_sci(1 + (alpha_inBody(7:9,relay_idx(3)).*exp(P_tilde(7:9)))/N(relay_idx(3)))) >= log(x_s(7:9) * T_frame)
        % right leg
        T_tilde(10:12) + log(W * log_sci(1 + (alpha_inBody(10:12,relay_idx(4)).*exp(P_tilde(10:12)))/N(relay_idx(4)))) >= log(x_s(10:12) * T_frame)
        % head
        T_tilde(13) + log(W * log_sci(1 + (alpha_inBody(13,relay_idx(5)).*exp(P_tilde(13)))/N(relay_idx(5)))) >= log(x_s(13) * T_frame)
        % Torso
        T_tilde(14:17) + log(W * log_sci(1 + (alpha_inBody(14:17,relay_idx(6)).*exp(P_tilde(14:17)))/N(relay_idx(6)))) >= log(x_s(14:17) * T_frame)
        
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
cvx_end

end

