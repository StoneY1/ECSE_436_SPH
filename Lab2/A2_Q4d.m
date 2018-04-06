%% A2_Q4d
clear
[audio,fs] = audioread('speech.wav');
length = length(audio);
SNR = -10;
amplitude = 1/(10^(SNR/10));
AWGN = amplitude*randn(1,length);
AWGN = AWGN';
prob = 0.9;
impulsive = amplitude*rand(1,length)<prob;
impulse = double(impulsive');

a_gaussian = AWGN+audio;
a_impulse = impulse+audio;
sound(a_impulse,fs);
%sound(a_gaussian,fs);
