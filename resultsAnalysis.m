clear all;
close all;
clc;

%% analysis over data rate
% 100 kbps
f1 = 100;
t_tilde(1) = 13.186737117100977;
t_tilde_singleHop(1) = 9.24856;
t_tilde_fixedRelayLocation(1) = 10.8154;
% 125 kbps
f2 = 125;
t_tilde(2) = 12.962013170151346;
t_tilde_singleHop(2) = 9.02109;
t_tilde_fixedRelayLocation(2) = 10.5899;
% 150 kbps
f3 = 150;
t_tilde(3) = 12.778728409195276;
t_tilde_singleHop(3) = 8.83394;
t_tilde_fixedRelayLocation(3) = 10.4084;
% 175 kbps
f4 = 175;
t_tilde(4) = 12.628512698106517;
t_tilde_singleHop(4) = 8.68945;
t_tilde_fixedRelayLocation(4) = 10.2573;
% 200 kbps
f5 = 200;
t_tilde(5) = 12.494405178542138;
t_tilde_singleHop(5) = NaN;
t_tilde_fixedRelayLocation(5) = 10.1188;
% 250 kbps
f6 = 250;
t_tilde(6) = 12.247213365266145;
t_tilde_singleHop(6) = NaN;
t_tilde_fixedRelayLocation(6) = 9.9007;
% 300 kbps
f7 = 300;
t_tilde(7) = 11.778000000000000;
t_tilde_singleHop(7) = NaN;
t_tilde_fixedRelayLocation(7) = 9.71687;

semilogy([f1 f2 f3 f4 f5 f6 f7], exp(t_tilde), 'ks-','linewidth',1.5);
hold on;
semilogy([f1 f2 f3 f4 f5 f6 f7],exp(t_tilde_singleHop), 'kv-','linewidth',1.5);
hold on;
semilogy([f1 f2 f3 f4 f5 f6 f7],exp(t_tilde_fixedRelayLocation), 'kd-','linewidth',1.5);

legend('The proposed network','Single-hop','Multi-hop with fixed relay location');

xlabel('Data rate/Kbps');
ylabel('Network lifetime/s');