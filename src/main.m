

% Clear everything i.e. memory, console, etc. and close all opened images
clear; clc; close all;

% Delete parallel pool of workers if any
delete(gcp('nocreate'));

% Delete Codebook i.e. 'BOW.mat' if it exists
if exist('BOW.mat', 'file') == 2
    delete('BOW.mat');
end

% Create new Codebook i.e. 'BOW.mat'
save('BOW.mat');

% Add 'VLFeat' to MATLAB environment
VLFEATROOT = './vlfeat-0.9.20/';
run([VLFEATROOT, 'toolbox/vl_setup']);

% Import project configuration i.e. 'Configuration.m'
Configuration;

% Train Bag of Words model
disp('Started training.....');
train(Config.TrainPath, Config.TrainCount, Config.Extension);
disp('Training completed.....');

% Test Bag of Words model
disp('Started testing.....');
test(Config.TestPath, Config.TestCount, Config.Extension);
disp('Testing completed.....');

