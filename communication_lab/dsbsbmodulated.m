clc;
close all;
t = 0:0.001:1;
vm = input('enter the amplitude of the cos wave-message signal');
fm = input('enter the frequency of the cos wave-message signal');
x = vm*cos(2*pi*fm*t);
subplot(5,1,1)
plot(t,x,'b')
title('message signal')
xlabel('time')
ylabel('amp')
grid on;


vc = input('enter the amplitude of the cos wave-carrier signal');
fc = input('enter the frequency of the cos wave-carrier signal');
c = vc*cos(2*pi*fc*t);
subplot(5,1,2)
plot(t,c,'b')
title('carrier signal')
xlabel('time')
ylabel('amp')
grid on;


sm = x.*cos(2*pi*fc*t);
subplot(5,1,3)
plot(t,sm,'b')
title('modulated signal')
xlabel('time')
ylabel('amp')
grid on;


dm = sm.*cos(2*pi*fc*t);
subplot(5,1,4)
plot(t,dm,'b')
title('demodulated signal without filter')
xlabel('time')
ylabel('amp')
grid on;

df = (1/2)*x;
subplot(5,1,5)
plot(t,df,'b')
title('demodulated signal with filter')
xlabel('time')
ylabel('amp')
grid on;

