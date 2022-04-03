clc;
clear all;
close all;
t=0:0.0001:1;
am=input('enter the message signal');
fm=input('enter the frequency of the message signal');
x=am*cos(2*pi*fm*t);
subplot(3,1,1)
plot(t,x,'b')
title('message signal')
xlabel('time')
ylabel('amp')
grid on;

vc=input('enter the amplitude of the carrier wave');
fc=input('enter the frequency of the carrier wave');
c=vc*cos(2*pi*fc*t);
subplot(3,1,2)
plot(t,c,'b')
title('carrier signal')
xlabel('time')
ylabel('amp')
grid on;

mf=input('enter the value of the modulated signal');
sf=vc*cos((2*pi*fc*t)+(mf*sin(2*pi*fm*t)));
subplot(3,1,3)
plot(t,sf,'r')
title('modulated signal')
xlabel('title')
ylabel('amplitude')
grid on;