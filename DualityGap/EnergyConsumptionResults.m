% 2016-05-25 by Yang Zhou
% Calculate the energy consumption per round for different data rate 


clear all;
close all;
clc;

%% Parameters
S_num = 17;
T_frame = 0.4; % s
f = [10, 20, 30, 40, 45, 50];

%% For 10 kbps 400ms
% For decomposition method
load('../Results_10kbps_400ms_binarysearch_decomposition.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
% netLifeTime = exp(t_tilde);
energyConsumption_proposed_decomposition(1) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];


% centralized method
load('Primal_Results_10kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(1) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
% % single hop
% load('SingleHop_Results_100kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
% P = exp(P_tilde(1:S_num));
% T = exp(T_tilde(1:S_num));
% energyConsumption_SingleHop(1) = sum(P .* T);

% Multihop FixedRelayLocation
load('../Multihop_FixedRelayLocation_Results_10kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(1) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
% Multihop FixedPower
load('../relayLocationControlAndFixedPower_Results_10kbps_400ms.mat','T_tilde_opt','t_tilde_opt');
P = -10 * ones(S_num, 1); % dBmW
P = 10.^(P/10) / 1000; % W
T = exp(T_tilde_opt(1:S_num));
energyConsumption_Multihop_FixedPower(1) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
%% For 20 kbps 400ms
load('../Results_20kbps_400ms_binarysearch_decomposition.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(2) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
load('Primal_Results_20kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(2) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
% % single hop
% load('SingleHop_Results_125kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
% P = exp(P_tilde(1:S_num));
% T = exp(T_tilde(1:S_num));
% energyConsumption_SingleHop(2) = sum(P .* T);

% Multihop FixedRelayLocation
load('../Multihop_FixedRelayLocation_Results_20kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(2) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
% Multihop FixedPower
load('../relayLocationControlAndFixedPower_Results_20kbps_400ms.mat','T_tilde_opt', 't_tilde_opt');
P = -10 * ones(S_num, 1); % dBmW
P = 10.^(P/10) / 1000; % W
T = exp(T_tilde_opt(1:S_num));
energyConsumption_Multihop_FixedPower(2) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
%% For 30 kbps 400ms
load('../Results_30kbps_400ms_binarysearch_decomposition.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(3) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
load('Primal_Results_30kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(3) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
% % single hop
% load('SingleHop_Results_150kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
% P = exp(P_tilde(1:S_num));
% T = exp(T_tilde(1:S_num));
% energyConsumption_SingleHop(3) = sum(P .* T);

% Multihop FixedRelayLocation
load('../Multihop_FixedRelayLocation_Results_30kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(3) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
% Multihop FixedPower
load('../relayLocationControlAndFixedPower_Results_30kbps_400ms.mat','T_tilde_opt','t_tilde_opt');
P = -10 * ones(S_num, 1); % dBmW
P = 10.^(P/10) / 1000; % W
T = exp(T_tilde_opt(1:S_num));
energyConsumption_Multihop_FixedPower(3) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
%% For 40 kbps 400ms
load('../Results_40kbps_400ms_binarysearch_decomposition.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(4) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
load('Primal_Results_40kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(4) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
% % single hop
% load('SingleHop_Results_175kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
% P = exp(P_tilde(1:S_num));
% T = exp(T_tilde(1:S_num));
% energyConsumption_SingleHop(4) = sum(P .* T);

% Multihop FixedRelayLocation
load('../Multihop_FixedRelayLocation_Results_40kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(4) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
% Multihop FixedPower
load('../relayLocationControlAndFixedPower_Results_40kbps_400ms.mat','T_tilde_opt','t_tilde_opt');
P = -10 * ones(S_num, 1); % dBmW
P = 10.^(P/10) / 1000; % W
T = exp(T_tilde_opt(1:S_num));
energyConsumption_Multihop_FixedPower(4) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
%% For 45 kbps 400ms
load('../Results_45kbps_400ms_binarysearch_decomposition.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(5) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
load('Primal_Results_45kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(5) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
% % Single hop
% energyConsumption_SingleHop(5) = [];

% Multihop FixedRelayLocation
load('../Multihop_FixedRelayLocation_Results_45kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(5) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
% Multihop FixedPower
load('../relayLocationControlAndFixedPower_Results_45kbps_400ms.mat','T_tilde_opt','t_tilde_opt');
P = -10 * ones(S_num, 1); % dBmW
P = 10.^(P/10) / 1000; % W
% T = exp(T_tilde_opt(1:S_num));
% energyConsumption_Multihop_FixedPower(5) = sum(P .* T);
energyConsumption_Multihop_FixedPower(5) = NaN;
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
%% For 50 kbps 400ms
load('../Results_50kbps_400ms_binarysearch_decomposition.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(6) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
load('Primal_Results_50kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(6) = sum(P .* T);
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
% % Single hop
% energyConsumption_SingleHop(6) = [];
% Multihop FixedRelayLocation
load('../Multihop_FixedRelayLocation_Results_50kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(6) = sum(P .* T);
T_tilde = [];
P_tilde = [];
t_tilde = [];
% Multihop FixedPower
load('../relayLocationControlAndFixedPower_Results_50kbps_400ms.mat','T_tilde_opt', 't_tilde_opt');
P = -10 * ones(S_num, 1); % dBmW
P = 10.^(P/10) / 1000; % W
% T = exp(T_tilde_opt(1:S_num));
% energyConsumption_Multihop_FixedPower(6) = sum(P .* T);
energyConsumption_Multihop_FixedPower(6) = NaN;
T_tilde_opt = [];
P_tilde_opt = [];
t_tilde_opt = [];
%% Plot
plot(f, energyConsumption_proposed_decomposition,'-+', f, energyConsumption_centralized, '-o', f, energyConsumption_Multihop_FixedRelayLocation,'-v',  f, energyConsumption_Multihop_FixedPower,'-*');
legend('Proposed network with decomposition method','Proposed network with centralized method','Multi-hop network with fixed relay location','Multi-hop network with fixed transmission power');

save('EnergyResults','energyConsumption_proposed_decomposition','energyConsumption_centralized','energyConsumption_Multihop_FixedRelayLocation','energyConsumption_Multihop_FixedPower');