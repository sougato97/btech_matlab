clear all
close all
t=0:0.01:2
fm=input('Enter the value of msg')
vm=input('Enter the value of msg')
fm1=input('Enter the value of fm carrier')
vm1=input('Enter the value of vm carrier')
m=vm*sin(2*pi*fm*t)
m1=vm1*sin(2*pi*fm1*t)
m2=(vm1+m).*cos(2*pi*fm*t)

subplot(3,1,1)
plot(t,m,'r')

title('message')
xlabel('time')
ylabel('amplitude')
grid on

subplot(3,1,2)
plot(t,m1,'g')

title('carrier')
xlabel('time')
ylabel('amplitude')
grid on

subplot(3,1,3)
plot(t,m2,'b')

title('spectrum')
xlabel('time')
ylabel('amplitude')
grid on




