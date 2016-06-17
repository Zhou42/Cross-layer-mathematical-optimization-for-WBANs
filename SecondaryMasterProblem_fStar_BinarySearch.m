function [ t_tilde, z, T_tilde, P_tilde] = SecondaryMasterProblem_fStar_BinarySearch(lambda )
%SECONDARYMASTERPROBLEM_FSTAR Summary of this function goes here
%   Detailed explanation goes here
% input: t_tilde, lambda
% output: t_tilde, z*, T_tilde*, P_tilde*
global S_num R_num threshold B T_frame W N P_max P_min alpha_inBody x_s r_relay theta buf_length F;
gamma = ones(S_num,1); % inital gamma values

% initial value for t_tilde
t_tilde_low = 10;
t_tilde_interval = 1;

diff = 1;
epoch = 1;
% buf_length = 10;
buf = zeros(buf_length,1);
sum_old = 0;

P_tilde = [];
T_tilde = [];
z = [];
%% Step 1: Find the upper bound of t_tilde*
t_tilde = t_tilde_low + t_tilde_interval;
[P_tilde, T_tilde, relay_idx, NO_SOLUTION_FLAG] = SecondaryMaster_SubProblemsAll(lambda,t_tilde);
% if NO_SOLUTION_FLAG == true, t_tilde > t_tilde*;
while NO_SOLUTION_FLAG ~= true
    t_tilde = t_tilde + t_tilde_interval;
    [P_tilde, T_tilde, relay_idx, NO_SOLUTION_FLAG] = SecondaryMaster_SubProblemsAll(lambda,t_tilde);
end
t_tilde_up = t_tilde;

%% Step 2: obtain the t_tilde_up and t_tilde_low bound that are close enough
while abs(t_tilde_up - t_tilde_low) > threshold * F
    t_tilde_mid = (t_tilde_up + t_tilde_low)/2;
    fprintf('Value of t_tilde_mid is %f\n',t_tilde_mid);
    [P_tilde, T_tilde, relay_idx, NO_SOLUTION_FLAG] = SecondaryMaster_SubProblemsAll(lambda,t_tilde_mid);
    
    if NO_SOLUTION_FLAG ~= true
        % if solution exist; calculate "t_tilde_delta"
        z = zeros(S_num + R_num, 1);
        z(relay_idx) = 1;
        gamma = getOptimalGamma_KKT( lambda, t_tilde_mid, T_tilde, P_tilde, z, relay_idx );
        t_tilde_delta = 1 - sum(gamma);
        
        if t_tilde_delta > 0
            % still increasing
            t_tilde_low = t_tilde_mid;
        else
            t_tilde_up = t_tilde_mid;
        end
    else 
        t_tilde_up = t_tilde_mid;
    end
end

% t_tilde = (t_tilde_up + t_tilde_low)/2;
%% make sure solution exits for t_tilde_mid
while NO_SOLUTION_FLAG == true
    t_tilde_up = t_tilde_mid;
    t_tilde_mid = (t_tilde_up + t_tilde_low)/2;
    [P_tilde, T_tilde, relay_idx, NO_SOLUTION_FLAG] = SecondaryMaster_SubProblemsAll(lambda,t_tilde_mid);
     fprintf('Value of t_tilde_mid is %f\n',t_tilde_mid);
end
t_tilde = t_tilde_mid;
% now for t_tilde, it has solutions and (P_tilde, T_tilde, relay_idx) are
% its solutions
z = zeros(S_num + R_num, 1);
z(relay_idx) = 1;

%% Step 3: Actually solve the optimal t_tilde*
% Comment for speed
% while diff > threshold
%     fprintf('Epoch %d, Tilde t is %f, Tilde Avg is %f, gamma_sum is %f, diff is %f\n', epoch, t_tilde,sum(buf)/buf_length, sum(gamma), diff);  
%     % A copy of the old values
%     P_tilde_old = P_tilde;
%     T_tilde_old = T_tilde;
%     t_tilde_old = t_tilde;
%     z_old = z;
%     %% Solve the primal problem f^*(\tilde t) and get z
%     [P_tilde, T_tilde, relay_idx, NO_SOLUTION_FLAG] = SecondaryMaster_SubProblemsAll(lambda,t_tilde);
%     % check if solution exists
%     if (NO_SOLUTION_FLAG == true)
%         P_tilde = P_tilde_old;
%         T_tilde = T_tilde_old;
%         t_tilde = t_tilde_old;
%         z = z_old;
%         return
%     end   
%     z = zeros(S_num + R_num, 1);
%     z(relay_idx) = 1;
%     %% solve d^*(gamma^*)
%     % By KKT
%     gamma = getOptimalGamma_KKT( lambda, t_tilde, T_tilde, P_tilde, z, relay_idx );
%     
%     % t_tilde_old = t_tilde;
%     t_tilde = t_tilde + theta * (1 - sum(gamma));
%     buf(mod(epoch,buf_length) + 1) = t_tilde;
%     
%     %% Iteration ending criteria; calculate diff each (buf_length) iterations
%     if (mod(epoch, buf_length) == 0)
%         diff = abs(sum_old - sum(buf))/buf_length;
%         sum_old = sum(buf);
%     end
%     
%     epoch = epoch + 1;
%    % toc;
% end
end


