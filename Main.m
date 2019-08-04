%TODO
%-Timestamps are wrong?

close all
clc
more off
format long
addpath(genpath('Helper'));
addpath(genpath('Initializers'));
addpath(genpath('Analyze'));
addpath(genpath('Graphing'));
datapath_directory = '/home/robot/test';
Initialize;

print_signals(Signals);
AnalyzeSignals;
DrawGraphs;