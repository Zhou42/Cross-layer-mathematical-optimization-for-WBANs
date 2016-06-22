function [ t_tilde, P_tilde, T_tilde ] = primalOptimalGivenZRelayNum( S2RMap )
%PRIMALOPTIMALGIVENZ Summary of this function goes here
%   Detailed explanation goes here
global S_num R_num C_num B T_frame W N P_max P_min alpha_inBody x_s r_relay;


% how to use S2RMap?????
% Group by relay index?

relaySet = unique(S2RMap(:, 2));
relayNum = length(relaySet);
sensorSets = cell(relayNum, 1);
for i = 1:relayNum
    idx_relay_i = find(S2RMap(:, 2) == relaySet(i));
    sensorSets{i} = S2RMap(idx_relay_i, 1);
    dataRateSumForEachRelay(i) = sum(x_s(sensorSets{i}) * T_frame);
end
dataRateSumForEachRelay = dataRateSumForEachRelay';

for jj = 1:S_num
    alpha_inBody_vec(jj) = alpha_inBody(jj,S2RMap(jj, 2));
end
alpha_inBody_vec = alpha_inBody_vec';

cvx_expert true
cvx_begin quiet
    variables T_tilde(S_num + R_num,1) P_tilde(S_num + R_num,1) t_tilde;
    maximize(t_tilde);
    subject to
        t_tilde + P_tilde(1:S_num) + T_tilde(1:S_num) <= log(T_frame * B(1:S_num))
        sum(exp(T_tilde(1:S_num))) + sum(exp(T_tilde(relaySet))) <= T_frame
        
        % Consider each sensor
        T_tilde(1:S_num) + log(W * log_sci((alpha_inBody_vec.*exp(P_tilde(1:S_num)))/N(1))) >= log(x_s(1:S_num) * T_frame)
      
        % Consider each relay
        log(r_relay(relaySet)' .* exp(T_tilde(relaySet))) >= log(dataRateSumForEachRelay)
        
        log(P_min) <= P_tilde(1:S_num) <= log(P_max)
cvx_end

end

