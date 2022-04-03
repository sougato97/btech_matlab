clc
close all
clear all
t=-1:0.001:1
vm=input('Input vm')
fm=input('Input fm')
m=vm*sin(2*pi*fm*t)
plot(t,m,'r')
title('sine wave')
XLABEL('time')
YLABEL('amplitude')
grid on;