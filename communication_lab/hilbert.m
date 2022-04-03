close all;
clc;
t=0:0.001:1;
am=input('Enter the amplitude of the message signal');
fm=input('Enter the frequency of the message signal');
x=am*cos(2*pi*fm*t);
subplot(5,1,1)
plot(t,x,'r')
title('message signal');
xlabel('time');
ylabel('amplitude');
grid on;


h = am*cos(2*pi*fm*t-pi/2);
subplot(5,1,2)
plot(t,h,'b')
title('hilbert signal');
xlabel('time');
ylabel('amplitude');
grid on;

ac=input('enter the amplitude of the carrier signal');
fc=input('enter the frequency of the carrier signal');
c=ac*cos(2*pi*fc*t);
subplot(5,1,3);
plot(t,c,'r')
title('carrier signal');
xlabel('time');
ylabel('amplitude');
grid on;


s1=x.*cos(2*pi*fc*t)-h.*sin(2*pi*fc*t)
subplot(5,1,4);
plot(t,s1,'b')
title('SSB-USB');
xlabel('time');
ylabel('amplitude');
grid on;


s2=x.*cos(2*pi*fc*t)+h.*sin(2*pi*fc*t)
subplot(5,1,5);
plot(t,s2,'b')
title('SSB-LSB');
xlabel('time');
ylabel('amplitude');
grid on;
