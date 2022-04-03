clc
close all
clear all
t=-1:0.001:1

vm=input('Input vm')
fm=input('Input fm')

m1=vm*sin(2*pi*fm*t)
m2=t-floor(t)
m3=vm*exp(t)



subplot(2,2,1)
plot(t,m1,'r')

subplot(2,2,2)
plot(t,m2,'g')

subplot(2,2,3)
plot(t,m3,'b')

title('sine wave')
XLABEL('time')
YLABEL('amplitude')
grid on;