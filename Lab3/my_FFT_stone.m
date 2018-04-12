%%my_FFT_Stone
clear
M = 30;
fs=1000;
Ts=1/fs;
t=(1:2^M)*Ts;
y=10*sin(2*pi*200*t)+5*sin(2*pi*400*t)+12*sin(2*pi*300*t);