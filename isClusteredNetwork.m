function [isClusteredNeural,nil1,nil2] = isClusteredNetwork(isClusteredInput,x,y)
%MYNEURALNETWORKFUNCTION neural network simulation function.
% 
% Generated by Neural Network Toolbox function genFunction, 14-Sep-2018 13:41:38.
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = 4xQ matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 1xQ matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [0.00119239540528857;0.0137152197738708;0.00133120937584319;0.0118391291861168];
x1_step1.gain = [0.0133716704733847;0.0134390209276308;0.0133508600020281;0.0133637161412659];
x1_step1.ymin = -1;

% Layer 1
b1 = [-4.3472169653689816116;-4.6320194139815598078;-0.60829769510096332041;-6.6340509127946063472;2.089895425199157053;-0.57393442159159846483;7.2423455935066414213;1.8239277038445254053;-0.3683780768839458597;6.2499737768167324958;-0.43569433640579735556;9.4704734483250820887;-4.5831063806423797402;4.8938333198157213388;-7.6149720973149142011;6.3771672392767149162];
IW1_1 = [5.7395930388063129968 -0.067034212402664439256 -2.1569045114977298816 0.4995368732341974316;7.3618424261591091096 -0.074433959589407142077 -2.7863797558892988704 0.65580171764775863075;-8.2427037443049577803 -1.2051306980655400736 2.9529925650788131364 -4.7734694522827130214;-18.192288841422499246 6.5478521594787828519 18.725102741233950354 -6.9567776589742544857;-6.4363461739852398935 -11.83610289662894921 6.3748627222105174184 11.833565554871070091;3.8552959623725491234 2.3116151524818162599 -3.8663547287775124062 -2.3407768819841097141;-37.968427697642425755 28.209443466182200666 37.926006671627156663 -28.427318385121690625;0.050978268162607372205 3.449685154302973622 14.505331299387306032 -5.6287596734916593988;2.3837770392639190398 1.4780830907479522995 -2.3844411435813275268 -1.4966050829898400742;-3.4226754925074831526 33.880754771012576043 2.4102056019586224345 -34.075999959257273986;2.9288708681486284036 1.8443020690480569357 -2.9334448267971784396 -1.8658948640250747619;51.162538518869709492 -5.3841880167318922901 -51.262294696087003842 5.0792138482692141821;4.0134119482517176536 -12.775568529219096803 -4.1554845025017073112 12.80389163425513388;16.669257920333954814 -25.62520636573456656 -16.975777054312839454 25.547835782033377683;-24.882216236575679602 -3.0459196565750796815 25.294539653940102397 3.5472284779049396697;-3.6216979144755505615 34.388798199965293634 2.4637540168211824465 -34.59261583404067153];

% Layer 2
b2 = 3.6090892175649167406;
LW2_1 = [7.5243554376553651863 -2.6635493438315283043 0.011161662223851415848 0.22262640426596458365 0.69723441632889915365 -14.052067326793928004 0.42806737379037185232 -0.021706310091958558317 -15.57584094565473265 6.5940654295419003361 29.904771132040924186 0.54696278603771397719 0.31789013078906336318 0.47815330204562450644 0.21443444730184393898 -6.120522401890503339];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 2;
y1_step1.xoffset = 0;

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(isClusteredInput);
if ~isCellX
    isClusteredInput = {isClusteredInput};
end

% Dimensions
TS = size(isClusteredInput,2); % timesteps
if ~isempty(isClusteredInput)
    Q = size(isClusteredInput{1},2); % samples/series
else
    Q = 0;
end

% Allocate Outputs
isClusteredNeural = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    Xp1 = mapminmax_apply(isClusteredInput{1,ts},x1_step1);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = repmat(b2,1,Q) + LW2_1*a1;
    
    % Output 1
    isClusteredNeural{1,ts} = mapminmax_reverse(a2,y1_step1);
end

% Final Delay States
nil1 = cell(1,0);
nil2 = cell(2,0);

% Format Output Arguments
if ~isCellX
    isClusteredNeural = cell2mat(isClusteredNeural);
end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
