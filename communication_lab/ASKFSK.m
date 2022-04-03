close all;
clear all;
clf;
fc1=5
fc2=80
n=[1 1 0 1 1]
l=length(n)
if n(l)==1
n(l+1)=1
else
 n(l+1)=0
end
l1=length(n)
tn=0:l1-1

subplot(5,1,1)
stairs(tn,n)
xlabel('time(s)');
ylabel('amplitude(v)');
title('message signal');

t=0:0.01:l
c1=sin(2*pi*fc1*t);
subplot(5,1,2);
plot(t,c1);
xlabel('time(s)');
ylabel('amplitude(v)');
title('carrier1 signal');
grid on;

t=0:0.01:l
c2=sin((2*pi*fc1*t)+pi);
subplot(5,1,3);
plot(t,c2);
xlabel('time(s)');
ylabel('amplitude(v)');
title('carrier2 signal');
grid on;

%fsk modulated signal 

for i=1:l
    for j=(i-1)*100:i*100
        if (n(i)==1)
        s(j+1)=c1(j+1)
        else
          s(j+1)=c2(j+1);
          end
end
end
subplot(5,1,4);
plot(t,s);
xlabel('time(s)');
xlabel('amplitude(v)');
title('fsk SIGNAL ');
%fsk demodulated signal generation

for i=1:l
    for j=(i-1)*100:i*100
        if (s(j+1)==c1(j+1))
       x(j+1)=1;
        else
          x(j+1)=0;
          end
end
end
subplot(5,1,5);
plot(t,x);
xlabel('time(s)');
xlabel('amplitude(v)');
title('fsk demodulated signal');
grid on;
