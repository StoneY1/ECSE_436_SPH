%ECSE 436 Jessica Udo, Stone Yun
%Lab 3 question 1a

clear;
%% acquiring signal data
f = 16000; %%declared playback frequency
h = audioread('h.wav'); %%reading in the impulse response and speech recording
[x,fs] = audioread('speech.wav'); 
%sound (x)

%signal FFT
x_fft = fft(x);
%plot (x_fft); %when doing a FT, we have a magnitude and a phase
%but we want just the magnitude, hence we take the absolute vlaue
%plot(abs(x_fft));
subplot(3,3,1);
plot (abs(x_fft));
xlabel('Number of samples');
ylabel('FFT of X');


%% Also we want the x-axis mapped to frequency
n = length(x);
f1 = 1:n/2;
f2 = 0;
f3 = fliplr(f1)*(-1);
freq = fs.*horzcat(f3,f2,f1)/n;

subplot(3,3,2);
plot (freq, abs(x_fft));
xlabel('Frequency');
ylabel('FFT of X');

%% we want to shift the fourier transform to appear like a realtime output
%seen on a spectrum analyzer
y_fft = fftshift(x_fft);
subplot(3,3,3);
plot(freq, abs(y_fft));
xlabel('Frequency');
ylabel('FFT shifted');

%% Low pass filtering begins here:
%STEP 1: To filter to 8kHz, we set corresponding DFT components to 0 
%for f < -4kHz and f > 4kHz
max(freq)
min(freq)
z_fft = zeros(134579, 0);
for i = 1 : 134579
    if freq(i) > 4000 || freq (i) < -4000
        z_fft(i) = 0;
    else
       z_fft(i) = y_fft(i);
        
    end
end
subplot(3,3,4);
plot(freq, abs(z_fft));
xlabel('Frequency');
ylabel('Filtered Output');


zshift_fft = fftshift(z_fft);
output = ifft(zshift_fft);

subplot(3,3,5);
plot(freq, abs(zshift_fft));
xlabel('Frequency');
ylabel('Filtered Output shifted');

subplot(3,3,6);
plot(abs(output));
xlabel('Frequency');
ylabel('Filtered Shifted Output (IFFT)');

%% Need to edit this to get output as a real dependency on time then sound
%arrayfun(@toTime, A);

t = 0:length(x) -1;
%sampling rate is 1/fs = Ts
time = t./fs; % the . takes every element in fs and divides them by fs
subplot(3,3,7);
plot(time, abs(output));
xlabel('Time domain');
ylabel('Output');

%% simulate AWGN noise
frequency = 3000;
SNR = 50;
var = 0.5/(10^(SNR/10)); %variance of Gaussian noise positive
e_gauss = var*randn(1,8); %erasure channel
noisy = mod(abs(x +e_gauss),2); %input at receiver 
%consider making lpf a function
noisy_fft = fft(noisy);
subplot(3,3,8);
plot (freq, abs(noisy_fft));
xlabel('Number of samples');
ylabel('FFT of noisy channel');
clear;
lpfUdoYun(noisy_fft, frequency);