%% Question 4b. Generating AWGN to corrupt the audio files with
clear
duration = 3;
fs = 16000;
t = 0:1/fs:duration;
SNR = -10;
amplitude = 0.5/(10^(SNR/10));
AWGN = amplitude*randn(1,length(t));
sound(AWGN,fs);

%%SNR: change amplitude of the signal; multiplying by amplitude is same as
%%manipulating sig_squared