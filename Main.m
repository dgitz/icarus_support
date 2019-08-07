%TODO
%-Timestamps are wrong? FIXED
%-CPU Usage should be divided by # of cores I think, and is converted in csv to 0
%First resource publish is invalid
%Free RAM looks wrong
%Free CPU looks wrong
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