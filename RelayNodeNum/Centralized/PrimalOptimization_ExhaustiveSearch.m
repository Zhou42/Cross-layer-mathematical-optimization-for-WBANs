% 2016-05-23 by Yang Zhou
% [1] Energy Efficiency Optimziation by Resource Allocation in Wireless Body Area Networks
% Description: 
% [2] Channel Models for Medical Implant Communication. 
% Channel model - Table 1: Deep tissue implant to body surface
%
% According to the simulation result from topology part, we can conclude  
% there are 17 sensor nodes, 38 relay Candidate Sites and 1 coordinator

% Power unit in this file is: W
% Time unit: second
% So energy should be: J

clc;
clear all;
close all;
cvx_solver Mosek
%% parameters
global S_num R_num C_num theta B T_frame W N P_max P_min alpha_inBody alpha_onBody x_s r_relay threshold buf_length F;
S_num = 17;
R_num = 40;
C_num = 1;
theta = 1e-2;
threshold = 1e-4;
% Battery level - relay has twice the energy of the sensor nodes
B = ones(S_num,1); % J
% Check the influence!!
T_frame = 0.4; % s
% only use one channel [3]
W = 3e5; % Hz
N = (10^(-17.4)*W) * ones(S_num + R_num + 1,1) /1000; % -174dBm/Hz [1]; Unit is W
P_max = 10^(0/10) / 1000; % W
P_min = 10^(-15/10) / 1000;
% P_min = 10^(-28/10) / 1000;n 

% coordinate
% im = imread('WBSNGraph.jpg');
% imshow(im);
x_body = 1137:170:1650;
y_body = [897 1075 1259 1464 1681];
[x_grid, y_grid] = meshgrid(x_body, y_body);

X = [
 114 913;
 359 841;
 491 1007;  % left arm - region 1
 2607 914;
 2364 841;
 2176 1004;  % right arm - region 2
 1199 2057;
 1054 2245;
 1050 2561;  % left leg - region 3
 1575 2036;
 1724 2228;
 1728 2578;  % right leg - region 4
 1387 312;  % head - region 5
 1594 1010;
 1387 1170;
 1502 1383;
 1111 1561;  % torso - region 6
           % sensors
 [235:170:750]' 916*ones(4,1); % Relay CS: left arm - 4 nodes
 [1923:170:2440]' 916*ones(4,1); % Relay CS: right arm - 4 nodes
 1120*ones(5,1) [1934:190:2740]'; % Relay CS: left leg - 4 nodes
 1642*ones(5,1) [1934:190:2740]'; % Relay CS: right leg - 4 nodes
 
 1145 427;
 1643 427; % Relay CS: head - 2 nodes
 
 reshape(x_grid,[20 1]) reshape(y_grid,[20 1]); % Relay CS: torso - 20 nodes
 1647 1592 % coordinator
];

%% Graph
% imshow(im);
% 
% % hold on;
% % scatter(X(:,1),X(:,2));
% % set(gca,'ydir','reverse','xaxislocation','top');
% 

% for i = 1:(S_num + R_num + 1)
%     text(X(i,1) ,X(i,2),num2str(i));
% end


% distance matrix; the image is 1022*1045 pixels
% !! This distance matrix needs to be updated to 3D-distance version!!
fac = 1500;
d = squareform(pdist(X)); % each row of X is (x_i,y_i)
D_inBody = d/fac; % transform unit from pixels into meters
D_onBody = d/fac;

% In-body Pathloss model for sensors [2]; for sensor 1~17 to relay CS 18~55
d_0_inBody = 0.05; % m
n_inBody = 4.26;
PL_0_inBody = 47.14; % dB
PL_inBody = PL_0_inBody + 10 * n_inBody * log(D_inBody/d_0_inBody)/log(10); % dB
for i = 1:S_num + R_num + 1
    PL_inBody(i, i) = 0;
end
alpha_inBody = 10.^( - PL_inBody./10);


% On-body Pathloss model for relays; relay CS 18~55 to coordinator
d_0_onBody = 0.1;
n_onBody  = 3.11;
PL_0_onBody = 35.2;
PL_onBody = PL_0_onBody + 10 * n_onBody * (log(D_onBody/d_0_onBody)/log(10));
for i = 1:S_num + R_num + 1
    PL_onBody(i, i) = 0;
end
alpha_onBody = 10.^( - PL_onBody./10);

% x_s - 50kbps for each node
% x_s = 50000 * ones(S_num,1) * 2.5; % bit/s - 100 kb seems to be proper for lambda to converge to a positive number
x_s = 40000 * ones(S_num,1);
% data rate of relay to coordinator
r_relay(S_num + 1:S_num + R_num) = W * log_sci(1 + (alpha_onBody(S_num + 1:S_num + R_num, S_num + R_num + 1).*P_max)/N(S_num + R_num + 1)); % bit/s

%% Exhaustive search for the optimal solution of the PRIMAL Problem
% 7 relays: one more on [left arm]
% 8 relays: one more on [left arm, right arm]
% 9 relays: one more on [left arm, right arm, left leg]
% 10 relays: one more on [left arm, right arm, left leg, right leg]
% 11 relays: one more on [left arm, right arm, left leg, right leg, torso]

t_tilde_opt = -inf;
Round = 1;
S2RMap = zeros(S_num, 2);
S2RMap(1:S_num,1) = 1:S_num;
tic;
% =============================left arm====================================
% for region left arm with 2 relays
for i_leftarm_1 = 18:20
for i_leftarm_2 = i_leftarm_1+1:21
    tic;
% % for region left arm with 1 relay
% for i_leftarm_1 = 18:21
%     i_leftarm_2 = i_leftarm_1;
    
    % obtain the mapping from sensor 1~3 to relay i_leftarm_1 and i_leftarm_2
    [~ , idx] = max(alpha_inBody(1:3, [i_leftarm_1 i_leftarm_2]), [], 2);
    temp = [i_leftarm_1 i_leftarm_2];
    S2RMap(1:3, 2) = temp(idx);
% =============================right arm====================================
    % for region right arm with 2 relays
    for i_rightarm_1 = 22:24
    for i_rightarm_2 = i_rightarm_1+1:25

%     % for region right arm with one relay
%     for i_rightarm_1 = 22:25 
%         i_rightarm_2 = i_rightarm_1;
        
        % obtain the mapping from sensor 4~6 to relay i_rightarm_1 and i_rightarm_2
        [~ , idx] = max(alpha_inBody(4:6, [i_rightarm_1 i_rightarm_2]), [], 2);
        temp = [i_rightarm_1 i_rightarm_2];
        S2RMap(4:6, 2) = temp(idx);
% =============================left leg====================================       
        % for region left leg with two relays    
        for i_leftleg_1 = 26:29
        for i_leftleg_2 = i_leftleg_1+1:30

%         % for region left leg with one relay    
%         for i_leftleg_1 = 26:30
%             i_leftleg_2 = i_leftleg_1;
            
            [~ , idx] = max(alpha_inBody(7:9, [i_leftleg_1 i_leftleg_2]), [], 2);
            temp = [i_leftleg_1 i_leftleg_2];
            S2RMap(7:9, 2) = temp(idx);
% =============================right leg===================================     
            % for region right leg with two relay
            for i_rightleg_1 = 31:34
            for i_rightleg_2 = i_rightleg_1+1:35

%             % for region right leg with one relay
%             for i_rightleg_1 = 31:35
%                 i_rightleg_2 = i_rightleg_1;

                [~ , idx] = max(alpha_inBody(10:12, [i_rightleg_1 i_rightleg_2]), [], 2);
                temp = [i_rightleg_1 i_rightleg_2];
                S2RMap(10:12, 2) = temp(idx);
% ================================head=====================================
                for i_head = 36:37
                    S2RMap(13,2) = i_head;
% ===============================torso=====================================   
                    % for region torso with two relays
%                     for i_torso_1 = 38:56  
                    for i_torso_1 = 54:56
                    for i_torso_2 = i_torso_1+1:57 

%                     % for region torso with one relay
%                     for i_torso_1 = 38:57
%                         i_torso_2 = i_torso_1;
 
                        [~ , idx] = max(alpha_inBody(14:17, [i_torso_1 i_torso_2]), [], 2);
                        temp = [i_torso_1 i_torso_2];
                        S2RMap(14:17, 2) = temp(idx); 
                        
% ==========================solve the problem==============================  
%                         % z is known, the problem is convex 
%                         relay_idx = [i_leftarm_1 i_rightarm_1 i_leftleg_1 i_rightleg_1 i_head i_torso_1];
%                         z = zeros(S_num + R_num, 1);
%                         z(relay_idx) = 1;
                        
                        % use S2RMap
                        relaySet = unique(S2RMap(:, 2));
                        relayNum = length(relaySet);
                        
                        [t_tilde, P_tilde, T_tilde] = primalOptimalGivenZRelayNum(S2RMap);   
                        if t_tilde_opt < t_tilde
                            t_tilde_opt = t_tilde;
                            P_tilde_opt = P_tilde;
                            T_tilde_opt = T_tilde;
%                             z_opt = z;
                            relaySet_opt = relaySet;
                        end
%                         fprintf('Round %d/16000, the optimal t_tilde is %f\n', Round,t_tilde_opt);
                        Round = Round + 1;
                    end 
                    end
                end
            end
            end
        end
        end
    end
    end
        switch length(relaySet_opt)
            case 7
                totalRoundNum = 6 * 4 * 5 * 5 * 2 * 20;
            case 8
                totalRoundNum = 6 * 6 * 5 * 5 * 2 * 20;
            case 9
                totalRoundNum = 6 * 6 * 10 * 5 * 2 * 20;
            case 10
                totalRoundNum = 6 * 6 * 10 * 10 * 2 * 20;
            case 11
                totalRoundNum = 6 * 6 * 10 * 10 * 2 * 190;
        end
        fprintf('Round %d/%d, the optimal t_tilde is %f\n', Round, totalRoundNum,t_tilde_opt);
        toc;
end
end
toc;
% filename = ['11PotentialRelays_Primal_Results_40kbps_400ms_' num2str(length(relaySet_opt)) 'Relays.mat'];
filename = ['11PotentialRelays_Primal_Results_40kbps_400ms_' num2str(relayNum) 'Relays_torso_1_54to56.mat'];
save(filename);
