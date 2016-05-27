% 2016-05-25 by Yang Zhou
% Calculate the energy consumption per round for different data rate 


clear all;
close all;
clc;

%% Parameters
S_num = 17;
T_frame = 0.4; % s
f = [100, 125, 150, 175, 200, 250, 300];

%% For 100 kbps 400ms
% For decomposition method
load('../Results_100kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
% netLifeTime = exp(t_tilde);
energyConsumption_proposed_decomposition(1) = sum(P .* T);

% centralized method
load('Primal_Results_100kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(1) = sum(P .* T);

% single hop
load('SingleHop_Results_100kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_SingleHop(1) = sum(P .* T);

% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_100kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(1) = sum(P .* T);

%% For 125 kbps 400ms
load('../Results_125kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(2) = sum(P .* T);


load('Primal_Results_125kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(2) = sum(P .* T);


% single hop
load('SingleHop_Results_125kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_SingleHop(2) = sum(P .* T);

% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_125kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(2) = sum(P .* T);

%% For 150 kbps 400ms
load('../Results_150kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(3) = sum(P .* T);

load('Primal_Results_150kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(3) = sum(P .* T);

% single hop
load('SingleHop_Results_150kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_SingleHop(3) = sum(P .* T);

% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_150kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(3) = sum(P .* T);
%% For 175 kbps 400ms
load('../Results_175kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(4) = sum(P .* T);

load('Primal_Results_175kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(4) = sum(P .* T);

% single hop
load('SingleHop_Results_175kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_SingleHop(4) = sum(P .* T);

% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_175kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(4) = sum(P .* T);
%% For 200 kbps 400ms
load('../Results_200kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(5) = sum(P .* T);

load('Primal_Results_200kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(5) = sum(P .* T);

% Single hop
energyConsumption_SingleHop(5) = NaN;

% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_200kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(5) = sum(P .* T);
%% For 250 kbps 400ms
load('../Results_250kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(6) = sum(P .* T);

load('Primal_Results_250kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(6) = sum(P .* T);

% Single hop
energyConsumption_SingleHop(6) = NaN;
% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_250kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(6) = sum(P .* T);
%% For 300 kbps 400ms
load('../Results_300kbps.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_proposed_decomposition(7) = sum(P .* T);

load('Primal_Results_300kbps_400ms.mat','T_tilde_opt','P_tilde_opt','t_tilde_opt');
P = exp(P_tilde_opt(1:S_num));
T = exp(T_tilde_opt(1:S_num));
energyConsumption_centralized(7) = sum(P .* T);

% Single hop
energyConsumption_SingleHop(7) = NaN;

% Multihop FixedRelayLocation
load('Multihop_FixedRelayLocation_Results_300kbps_400ms.mat','T_tilde','P_tilde','t_tilde');
P = exp(P_tilde(1:S_num));
T = exp(T_tilde(1:S_num));
energyConsumption_Multihop_FixedRelayLocation(7) = sum(P .* T);

%% Plot
plot(f, energyConsumption_proposed_decomposition, f, energyConsumption_centralized, f, energyConsumption_SingleHop, f, energyConsumption_Multihop_FixedRelayLocation);
legend('Proposed network with decomposition method','Proposed network with centralized method','Single-hop network','Multi-hop network with fixed relay location');

save('EnergyResults','energyConsumption_proposed_decomposition','energyConsumption_centralized','energyConsumption_SingleHop','energyConsumption_Multihop_FixedRelayLocation');