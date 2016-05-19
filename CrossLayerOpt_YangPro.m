% 2016-05-04 by Yang Zhou
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
global S_num R_num C_num theta B T_frame W N P_max P_min alpha_inBody alpha_onBody x_s r_relay threshold buf_length;
S_num = 17;
R_num = 38;
C_num = 1;
theta = 1e-2;
threshold = 1e-4;
% Battery level - relay has twice the energy of the sensor nodes
B = ones(S_num,1); % J
T_frame = 0.4; % s
W = 3e6; % Hz
N = (10^(-17.4)*W) * ones(S_num + R_num + 1,1) /1000; % -174dBm/Hz [1]; Unit is W
P_max = 10^(0/10) / 1000; % W
P_min = 10^(-28/10) / 1000;
% coordinator
im = imread('WBSNGraph.jpg');
x_body = 415:57:590;
y_body = 356:65:630;
[x_grid, y_grid] = meshgrid(x_body, y_body);

X = [
 73 364;
 154 338;
 154 388;  % left arm
 905 363;
 824 338;
 824 388;  % right arm
 436 764;
 412 826;
 380 889;  % left leg
 554 764;
 587 827;
 618 889;  % right leg
 499 163;
 568 395;
 499 451;
 530 539;
 406 579;  % head & body
           % sensors
 [113:57:290]' 363*ones(4,1); % Relay CS: left arm - 4 nodes
 [677:57:860]' 363*ones(4,1); % Relay CS: right arm - 4 nodes
 409*ones(5,1) [705:65:980]'; % Relay CS: left leg - 4 nodes
 583*ones(5,1) [705:65:980]'; % Relay CS: right leg - 4 nodes
 reshape(x_grid,[20 1]) reshape(y_grid,[20 1]); % - 20 nodes
 584 590
];

%% Graph
% imshow(im);
% 
% % hold on;
% % scatter(X(:,1),X(:,2));
% % set(gca,'ydir','reverse','xaxislocation','top');
% 
% for i = 1:(S_num + R_num + 1)
%     text(X(i,1),X(i,2),num2str(i));
% end


% distance matrix; the image is 1022*1045 pixels
% !! This distance matrix needs to be updated to 3D-distance version!!
d = squareform(pdist(X)); % each row of X is (x_i,y_i)
D_inBody = d/470; % transform unit from pixels into meters
D_onBody = d/470;

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
x_s = 300000 * ones(S_num,1);
% data rate of relay to coordinator
r_relay(S_num + 1:S_num + R_num) = W * log_sci(1 + (alpha_onBody(S_num + 1:S_num + R_num,56).*P_max)/N(56)); % bit/s


%% Gradient 
% lambda = 0.1;
lambda = 6.8;
% % t_tilde = 12.259086; 
% % t_tilde = 12.269132; 
% t_tilde = 12;
lambda_epoch = 1;

buf_length = 10;
buf = zeros(buf_length,1);
sum_old = 0;
diff = 1;

while diff > threshold
    tic;
    fprintf('Lambda epoch %d, Lambda is %f\n',lambda_epoch, lambda);
    % initial value for t_tilde
    t_tilde = 11.7810;
    % Obtain t_tilde to update \lambda
    [t_tilde, z, T_tilde, P_tilde] = SecondaryMasterProblem_fStar(t_tilde, lambda);
    lambda = lambda + 10 * theta * (sum(exp(T_tilde(1:S_num))) + exp(T_tilde(1:(S_num+R_num))')*z - T_frame);
    % lambda = lambda + 0.001 * (sum(exp(T_tilde(1:S_num))) + exp(T_tilde(1:(S_num+R_num))')*z - T_frame);
    lambda = max(lambda, 0);
    buf(mod(lambda_epoch,buf_length) + 1) = lambda;
    %% Iteration ending criteria; calculate diff each (buf_length) iterations
    if (mod(lambda_epoch, buf_length) == 1)
        diff = abs(sum_old - sum(buf))/buf_length;
        sum_old = sum(buf);
    end
    
    lambda_epoch = lambda_epoch + 1;
    toc;
end


%% Graph
imshow(im);

% hold on;
% scatter(X(:,1),X(:,2));
% set(gca,'ydir','reverse','xaxislocation','top');

for i = 1:(S_num + R_num + 1)
    text(X(i,1),X(i,2),num2str(i));
end
