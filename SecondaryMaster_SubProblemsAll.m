function [ P_tilde, T_tilde, relay_idx, NO_SOLUTION_FLAG ] = SecondaryMaster_SubProblemsAll(lambda, t_tilde)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% The inputs include \lambda, \tilde t
% The outputs are P_tilde, P_tilde, the relay that is selected in each
% region

% A typical runtime is 5~6 seconds 

global S_num R_num C_num B T_frame W N P_max P_min alpha_inBody alpha_onBody x_s r_relay;
NO_SOLUTION_FLAG = false;

f_obj_subproblems = [];
T_tilde = zeros(S_num+R_num, 1);
P_tilde = zeros(S_num, 1);
relay_idx = [];
%% for Region 1, left arm
relay_idx(1) = 18;
obj_value = -inf;
for relay_idx_temp = 18:21
    cvx_begin quiet
        variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
        maximize( - lambda * (sum(exp(T_tilde_temp(1:3))) + exp(T_tilde_temp(relay_idx_temp))));
        subject to
            t_tilde + P_tilde_temp(1:3) + T_tilde_temp(1:3) <= log(T_frame * B(1:3))
    %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
            T_tilde_temp(1:3) + log(W * log_sci((alpha_inBody(1:3,relay_idx_temp).*exp(P_tilde_temp(1:3)))/N(relay_idx_temp))) >= log(x_s(1:3) * T_frame)
            log(r_relay(relay_idx_temp) * exp(T_tilde_temp(relay_idx_temp))) >= log(sum(x_s(1:3) * T_frame))
            log(P_min) <= P_tilde_temp(1:3) <= log(P_max)
    cvx_end
    % there are 3 things need to be updated: sensor's P and T, relay's T
    if obj_value < (- lambda * (sum(exp(T_tilde_temp(1:3))) + exp(T_tilde_temp(relay_idx_temp))))
        relay_idx(1) = relay_idx_temp;
        obj_value = (- lambda * (sum(exp(T_tilde_temp(1:3))) + exp(T_tilde_temp(relay_idx_temp))));
        T_tilde(1:3) = T_tilde_temp(1:3);
        P_tilde(1:3) = P_tilde_temp(1:3);
        T_tilde(relay_idx(1)) = T_tilde_temp(relay_idx(1));
    end
end
% check if all solution T_tilde_temp and P_tilde_temp are NaN, that is  no solution for
% this subproblem
if obj_value == -inf
    NO_SOLUTION_FLAG = true;
    return
end

f_obj_subproblems(1) = - lambda * (sum(exp(T_tilde(1:3))) + exp(T_tilde(relay_idx(1))));
% f_obj_subproblems(1) = - lambda * (sum(exp(T_tilde(1:3))) + exp(T_tilde(21)));
%% for Region 2, right arm
relay_idx(2) = 22;
obj_value = -inf;
for relay_idx_temp = 22:25
    cvx_begin quiet
        variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
        maximize( - lambda * (sum(exp(T_tilde_temp(4:6))) + exp(T_tilde_temp(relay_idx_temp))));
        subject to
            t_tilde + P_tilde_temp(4:6) + T_tilde_temp(4:6) <= log(T_frame * B(4:6))
    %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
            T_tilde_temp(4:6) + log(W * log_sci((alpha_inBody(4:6,relay_idx_temp).*exp(P_tilde_temp(4:6)))/N(relay_idx_temp))) >= log(x_s(4:6) * T_frame)
            log(r_relay(relay_idx_temp) * exp(T_tilde_temp(relay_idx_temp))) >= log(sum(x_s(4:6) * T_frame))
            log(P_min) <= P_tilde_temp(4:6) <= log(P_max)
    cvx_end

    if obj_value < (- lambda * (sum(exp(T_tilde_temp(4:6))) + exp(T_tilde_temp(relay_idx_temp))))
        relay_idx(2) = relay_idx_temp;
        obj_value = (- lambda * (sum(exp(T_tilde_temp(4:6))) + exp(T_tilde_temp(relay_idx_temp))));
        T_tilde(4:6) = T_tilde_temp(4:6);
        P_tilde(4:6) = P_tilde_temp(4:6);
        T_tilde(relay_idx(2)) = T_tilde_temp(relay_idx(2));
    end
end
% check if all solution T_tilde_temp and P_tilde_temp are NaN, that is  no solution for
% this subproblem
if obj_value == -inf
    NO_SOLUTION_FLAG = true;
    return
end

f_obj_subproblems(2) =  - lambda * (sum(exp(T_tilde(4:6))) + exp(T_tilde(relay_idx(2))));
% f_obj_subproblems(2) =  - lambda * (sum(exp(T_tilde(4:6))) + exp(T_tilde(25)));
%% for Region 3, left leg
relay_idx(3) = 26;
obj_value = -inf;
for relay_idx_temp = 26:30
    cvx_begin quiet
        variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
        maximize( - lambda * (sum(exp(T_tilde_temp(7:9))) + exp(T_tilde_temp(relay_idx_temp))));
        subject to
            t_tilde + P_tilde_temp(7:9) + T_tilde_temp(7:9) <= log(T_frame * B(7:9))
    %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
            T_tilde_temp(7:9) + log(W * log_sci((alpha_inBody(7:9,relay_idx_temp).*exp(P_tilde_temp(7:9)))/N(relay_idx_temp))) >= log(x_s(7:9) * T_frame)
            log(r_relay(relay_idx_temp) * exp(T_tilde_temp(relay_idx_temp))) >= log(sum(x_s(7:9) * T_frame))
            log(P_min) <= P_tilde_temp(7:9) <= log(P_max)
    cvx_end

    if obj_value < (- lambda * (sum(exp(T_tilde_temp(7:9))) + exp(T_tilde_temp(relay_idx_temp))))
        relay_idx(3) = relay_idx_temp;
        obj_value = (- lambda * (sum(exp(T_tilde_temp(7:9))) + exp(T_tilde_temp(relay_idx_temp))));
        T_tilde(7:9) = T_tilde_temp(7:9);
        P_tilde(7:9) = P_tilde_temp(7:9);
        T_tilde(relay_idx(3)) = T_tilde_temp(relay_idx(3));
    end
end
% check if all solution T_tilde_temp and P_tilde_temp are NaN, that is  no solution for
% this subproblem
if obj_value == -inf
    NO_SOLUTION_FLAG = true;
    return
end

f_obj_subproblems(3) = - lambda * (sum(exp(T_tilde(7:9))) + exp(T_tilde(relay_idx(3))));
% f_obj_subproblems(3) = - lambda * (sum(exp(T_tilde_temp(7:9))) + exp(T_tilde_temp(30)));
%% for Region 4, right leg
relay_idx(4) = 31;
obj_value = -inf;
for relay_idx_temp = 31:35
    cvx_begin quiet
        variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
        maximize( - lambda * (sum(exp(T_tilde_temp(10:12))) + exp(T_tilde_temp(relay_idx_temp))));
        subject to
            t_tilde + P_tilde_temp(10:12) + T_tilde_temp(10:12) <= log(T_frame * B(10:12))
    %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
            T_tilde_temp(10:12) + log(W * log_sci((alpha_inBody(10:12,relay_idx_temp).*exp(P_tilde_temp(10:12)))/N(relay_idx_temp))) >= log(x_s(10:12) * T_frame)
            log(r_relay(relay_idx_temp) * exp(T_tilde_temp(relay_idx_temp))) >= log(sum(x_s(10:12) * T_frame))
            log(P_min) <= P_tilde_temp(10:12) <= log(P_max)
    cvx_end

    if obj_value < (- lambda * (sum(exp(T_tilde_temp(10:12))) + exp(T_tilde_temp(relay_idx_temp))))
        relay_idx(4) = relay_idx_temp;
        obj_value = (- lambda * (sum(exp(T_tilde_temp(10:12))) + exp(T_tilde_temp(relay_idx_temp))));
        T_tilde(10:12) = T_tilde_temp(10:12);
        P_tilde(10:12) = P_tilde_temp(10:12);
        T_tilde(relay_idx(4)) = T_tilde_temp(relay_idx(4));
    end
end
% check if all solution T_tilde_temp and P_tilde_temp are NaN, that is  no solution for
% this subproblem
if obj_value == -inf
    NO_SOLUTION_FLAG = true;
    return
end

f_obj_subproblems(4) = - lambda * (sum(exp(T_tilde(10:12))) + exp(T_tilde(relay_idx(4))));
% f_obj_subproblems(4) = - lambda * (sum(exp(T_tilde_temp(10:12))) + exp(T_tilde_temp(35)));
%% for Region 5, head
relay_idx(5) = 36;
obj_value = -inf;
for relay_idx_temp = 36:37
    cvx_begin quiet
        variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
        maximize( - lambda * (sum(exp(T_tilde_temp(13))) + exp(T_tilde_temp(relay_idx_temp))));
        subject to
            t_tilde + P_tilde_temp(13) + T_tilde_temp(13) <= log(T_frame * B(13))
    %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
            T_tilde_temp(13) + log(W * log_sci((alpha_inBody(13,relay_idx_temp).*exp(P_tilde_temp(13)))/N(relay_idx_temp))) >= log(x_s(13) * T_frame)
            log(r_relay(relay_idx_temp) * exp(T_tilde_temp(relay_idx_temp))) >= log(sum(x_s(13) * T_frame))
            log(P_min) <= P_tilde_temp(13) <= log(P_max)
    cvx_end

    if obj_value < (- lambda * (sum(exp(T_tilde_temp(13))) + exp(T_tilde_temp(relay_idx_temp))))
        relay_idx(5) = relay_idx_temp;
        obj_value = (- lambda * (sum(exp(T_tilde_temp(13))) + exp(T_tilde_temp(relay_idx_temp))));
        T_tilde(13) = T_tilde_temp(13);
        P_tilde(13) = P_tilde_temp(13);
        T_tilde(relay_idx(5)) = T_tilde_temp(relay_idx(5));
    end
end

T_tilde = T_tilde';
P_tilde = P_tilde';

% check if all solution T_tilde_temp and P_tilde_temp are NaN, that is  no solution for
% this subproblem
if obj_value == -inf
    NO_SOLUTION_FLAG = true;
    return
end

f_obj_subproblems(5) =  - lambda * (sum(exp(T_tilde(13))) + exp(T_tilde(relay_idx(5))));


%% for Region 6, torso
relay_idx(6) = 38;
obj_value = -inf;
for relay_idx_temp = 38:57
    cvx_begin quiet
        variables T_tilde_temp(S_num + R_num,1) P_tilde_temp(S_num + R_num,1);
        maximize( - lambda * (sum(exp(T_tilde_temp(14:17))) + exp(T_tilde_temp(relay_idx_temp))));
        subject to
            t_tilde + P_tilde_temp(14:17) + T_tilde_temp(14:17) <= log(T_frame * B(14:17))
    %         T_tilde(1:3) + log(W * log_sci(1 + (alpha_inBody(1:3,19).*exp(P_tilde(1:3)))/N(19))) >= log(x_s(1:3))
            T_tilde_temp(14:17) + log(W * log_sci((alpha_inBody(14:17,relay_idx_temp).*exp(P_tilde_temp(14:17)))/N(relay_idx_temp))) >= log(x_s(14:17) * T_frame)
            log(r_relay(relay_idx_temp) * exp(T_tilde_temp(relay_idx_temp))) >= log(sum(x_s(14:17) * T_frame))
            log(P_min) <= P_tilde_temp(14:17) <= log(P_max)
    cvx_end

    if obj_value < (- lambda * (sum(exp(T_tilde_temp(14:17))) + exp(T_tilde_temp(relay_idx_temp))))
        relay_idx(6) = relay_idx_temp;
        obj_value = (- lambda * (sum(exp(T_tilde_temp(14:17))) + exp(T_tilde_temp(relay_idx_temp))));
        T_tilde(14:17) = T_tilde_temp(14:17);
        P_tilde(14:17) = P_tilde_temp(14:17);
        T_tilde(relay_idx(6)) = T_tilde_temp(relay_idx(6));
    end
end

T_tilde = T_tilde';
P_tilde = P_tilde';

% check if all solution T_tilde_temp and P_tilde_temp are NaN, that is  no solution for
% this subproblem
if obj_value == -inf
    NO_SOLUTION_FLAG = true;
    return
end

f_obj_subproblems(6) =  - lambda * (sum(exp(T_tilde(14:17))) + exp(T_tilde(relay_idx(6))));

%%
f_obj = sum(f_obj_subproblems) + t_tilde + lambda * T_frame;
% fprintf('The primal solution f*(t_tilde, lambda) is %f\n',f_obj);

end

