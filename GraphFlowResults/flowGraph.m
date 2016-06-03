clear all;
close all;
clc;

load('../Results_175kbps.mat');

relay_idx = find(z == 1);
%% data rate of the sensors
r(1:3) = W * log_sci((alpha_inBody(1:3,relay_idx(1)).*exp(P_tilde(1:3)))/N(relay_idx(1)));
r(4:6) = W * log_sci((alpha_inBody(4:6,relay_idx(2)).*exp(P_tilde(4:6)))/N(relay_idx(2)));
r(7:9) = W * log_sci((alpha_inBody(7:9,relay_idx(3)).*exp(P_tilde(7:9)))/N(relay_idx(3)));
r(10:12) = W * log_sci((alpha_inBody(10:12,relay_idx(4)).*exp(P_tilde(10:12)))/N(relay_idx(4)));
r(13:17) = W * log_sci((alpha_inBody(13:17,relay_idx(5)).*exp(P_tilde(13:17)))/N(relay_idx(5)));
% data of relays
r_relay(relay_idx);

%% relay mapping
relay = [ones(3,1) * relay_idx(1); 
    ones(3,1) * relay_idx(2);
    ones(3,1) * relay_idx(3);
    ones(3,1) * relay_idx(4);
    ones(5,1) * relay_idx(5)];
map = [[1:S_num]' relay];

%% show image
im = imread('../WBSNGraph_result0.jpg');
imshow(im);

%% offset adjustment
offset  = [626 192] - X(13,:);
X = X + repmat(offset, S_num + R_num + 1, 1);

% for i = 1:(S_num + R_num + 1)
%     text(X(i,1),X(i,2),num2str(i));
% end

% figure;
% % set(gcf, 'position', [0 0 800 800]);
% scatter(X(1:S_num,1),X(1:S_num,2), 'filled','bo');
% hold on;
% scatter(X(S_num + 1:S_num + R_num,1),X(1 + S_num:S_num + R_num,2),'k+','Linewidth',2);
% set(gca,'ydir','reverse');
% set(gca,'xtick',[])
% set(gca,'ytick',[])
% axis equal 
%% plot sensor to relays
for i = 1:S_num
    hold on;
    plot([X(i,1) X(map(i, 2),1)], [X(i,2) X(map(i, 2),2)], 'Linewidth',r(i) * 4/1e7,'color','k');
end

%% plot relay to coordinator
for i = 1:numel(relay_idx)
    hold on;
    plot([X(relay_idx(i),1) X(S_num + R_num + 1,1)], [X(relay_idx(i),2) X(S_num + R_num + 1,2)], 'Linewidth',r(i) * 4/1e7,'color','k');
    r_relay
end

