% This file is used to test whether S/N >> 1 is satisfied
clear all;
close all;
clc;

%%
load('relayLocationControlAndFixedPower_Results_100kbps_400ms.mat','alpha_inBody');
P_min = 10^(-15/10) / 1000;
% W = 3e6; % Hz
W = 3e5; % Hz
S_num = 17;
R_num = 38;
N = (10^(-17.4)*W) * ones(S_num + R_num + 1,1) /1000; % -174dBm/Hz [1]; Unit is W
%% Coordinates
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
 498 208;
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
d = squareform(pdist(X)); % each row of X is (x_i,y_i)
D_inBody = d/600; % transform unit from pixels into meters
D_onBody = d/600;

%% In-body Pathloss model for sensors [2]; for sensor 1~17 to relay CS 18~55
d_0_inBody = 0.05; % m
n_inBody = 4.26;
PL_0_inBody = 47.14; % dB
PL_inBody = PL_0_inBody + 10 * n_inBody * log(D_inBody/d_0_inBody)/log(10); % dB
for i = 1:S_num + R_num + 1
    PL_inBody(i, i) = 0;
end
alpha_inBody = 10.^( - PL_inBody./10);

%%
SNR = P_min*alpha_inBody(14, 40)/N(1);

%% Graph
imshow(im);

% hold on;
% scatter(X(:,1),X(:,2));
% set(gca,'ydir','reverse','xaxislocation','top');

for i = 1:(S_num + R_num + 1)
    text(X(i,1),X(i,2),num2str(i));
end