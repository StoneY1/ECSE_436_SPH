%% Question 4c - additive impulsive noise of various probabilities
clear
duration = 3;
fs = 16000;
t = 0:1/fs:duration;
length = length(t);
SNR = 0;
amplitude = 0.5/(10^(SNR/10));
prob = 0.9;
impulsive = amplitude*rand(1,length)<prob;
impulse = double(impulsive);
sound(impulse,fs);