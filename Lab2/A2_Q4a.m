%% Q4a generating pure tones of various frequency and seeing edges of our hearing
clear
f = 10000;
fs = 50000;
amp = 10;
duration = 3;
t = 0:1/fs:duration;
a=amp*cos(2*pi*f*t);
sound(a,fs);
T = 2*pi/f;
plot(t,a);
xlim([0,2*T]);
ylim([-amp,amp]);

