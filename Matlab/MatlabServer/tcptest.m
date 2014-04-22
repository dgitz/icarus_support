%tcptest
close all
clear all
clc
t = tcpip('0.0.0.0',5005,'NetworkRole','server');
fopen(t)
while(1)
    strcat(char(fread(t,12))')
end
