function [ P_tilde, T_tilde, relay_idx ] = SecondaryMaster_SubProblem_Separate(lambda, t_tilde, region_idx  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% The inputs include \lambda, \tilde t, region index
% The outputs are P_tilde, P_tilde, the relay that is selected in this
% region

% Another choice would be to solve all the subproblems in this file; this
% would expodite the calculation speed!!

global S_num R_num C_num B T_frame W N P_max P_min alpha_inBody alpha_onBody x_s r_relay;

switch region_idx
    case 'Region_1'
        relay_idx = 18;
        obj_value = -inf;
        for relay_idx_temp = 18:21
            cvx_begin
                variables T_tilde(S_num + R_num,1) P_tilde(S_num + R_num,1);
                maximize( - lambda * (sum(exp(T_tilde(1:3))) + exp(T_tilde(relay_idx_temp))));
                subject to
                    t_tilde + P_tilde(1:3) + T_tilde(1:3) <= log(T_frame * B(1:3))
            %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
                    T_tilde(1:3) + log(W * log_sci((alpha_inBody(1:3,relay_idx_temp).*exp(P_tilde(1:3)))/N(relay_idx_temp))) >= log(x_s(1:3) * T_frame)
                    log(r_relay(relay_idx_temp) * exp(T_tilde(relay_idx_temp))) >= log(sum(x_s(1:3) * T_frame))
                    log(P_min) <= P_tilde(1:3) <= log(P_max)
            cvx_end
            
            if obj_value < (- lambda * (sum(exp(T_tilde(1:3))) + exp(T_tilde(relay_idx_temp))))
                relay_idx = relay_idx_temp;
                obj_value = (- lambda * (sum(exp(T_tilde(1:3))) + exp(T_tilde(relay_idx_temp))));
            end
            (- lambda * (sum(exp(T_tilde(1:3))) + exp(T_tilde(relay_idx_temp))))
        end
    case 'Region_2'  
        
        
    case 'Region_3'   
        
    case 'Region_4'    
        
        
    case 'Region_5'
        
    otherwise
        disp('Wrong region number! there are only 5 regions!');
end
end

