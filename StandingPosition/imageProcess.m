clc;
clear all;
close all;

im = imread('WBSNGraph-2.jpg');
imshow(im);

%% Position 1
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

%% Position 2
x_body = 1137:170:1650;
y_body = [897 1075 1259 1464 1681];
[x_grid, y_grid] = meshgrid(x_body, y_body);

X = [
    822 1618;
    750 1374;
    914 1246; % left arm - region 1
    1950 1582;
    2030 1338;
    1858 1150;% right arm - region 2
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
    822 * ones(4,1) [1490:-170:975]'; % Relay CS: left arm - 4 nodes
    1950 * ones(4,1) [894:170:1450]'; % Relay CS: right arm - 4 nodes
    1120*ones(5,1) [1934:190:2740]'; % Relay CS: left leg - 4 nodes
    1642*ones(5,1) [1934:190:2740]'; % Relay CS: right leg - 4 nodes

    1145 427;
    1643 427; % Relay CS: head - 2 nodes

    reshape(x_grid,[20 1]) reshape(y_grid,[20 1]); % Relay CS: torso - 20 nodes
    1647 1592 % coordinator
];

%% Position 3
x_body = 1137:170:1650;
y_body = [897 1075 1259 1464 1681];
[x_grid, y_grid] = meshgrid(x_body, y_body);

X = [
    822 1618;
    750 1374;
    914 1246;  % left arm - region 1
    1950 1582;
    2030 1338;
    1858 1150; % right arm - region 2
    1074 2050;
    802 2234;
    610 2558;  % left leg - region 3
    1694 2026;
    1958 2226;
    2170 2566; % right leg - region 4
    1387 312;  % head - region 5
    1594 1010;
    1387 1170;
    1502 1383;
    1111 1561;  % torso - region 6
           % sensors
    822 * ones(4,1) [1490:-170:975]'; % Relay CS: left arm - 4 nodes
    1950 * ones(4,1) [894:170:1450]'; % Relay CS: right arm - 4 nodes
    1046 1934;
    942 2110;
    838 2298;
    714 2502;
    594 2718; % Relay CS: left leg - 4 nodes
    1706 1930;
    1814 2110;
    1918 2302;
    2034 2498;
    2158 2718; % Relay CS: right leg - 4 nodes
    
    1145 427;
    1643 427; % Relay CS: head - 2 nodes

    reshape(x_grid,[20 1]) reshape(y_grid,[20 1]); % Relay CS: torso - 20 nodes
    1647 1592 % coordinator
];

% hold on;
% scatter(X(:,1),X(:,2));
% set(gca,'ydir','reverse','xaxislocation','top');