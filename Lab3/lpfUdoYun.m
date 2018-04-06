%%%ECSE 436 Jessica Udo, Stone Yun
%Lab 3 question 1a
%will make lpf a function:
function [outputshifted_fft] = lpfUdoYun(input_fft, input_freq)

%% Low pass filtering begins here:
%STEP 1: To filter to 8kHz, we set corresponding DFT components to 0 
%for f < -4kHz and f > 4kHz

%% Also we want the x-axis mapped to frequency
[x,fs] = audioread('speech.wav'); 
n = length(x);
f1 = 1:n/2;
f2 = 0;
f3 = fliplr(f1)*(-1);
freq = fs.*horzcat(f3,f2,f1)/n;

% subplot(2,2,1);
% plot (freq, abs(input_fft));
% xlabel('Frequency');
% ylabel('FFT of X');

y_fft = fftshift(input_fft);
subplot(2,2,1);
plot(freq, abs(y_fft));
xlabel('Frequency');
ylabel('FFT shifted');
axis([-5000, 5000, 0, 2000]); %zooms in for clearer graph

frequency = input_freq/2;

z_fft = zeros(134579, 0);
for i = 1 : 134579
    if freq(i) > frequency || freq (i) < -frequency
        z_fft(i) = 0;
    else
       z_fft(i) = y_fft(i);
        
    end
end
subplot(2,2,2);
plot(freq, abs(z_fft));
xlabel('Frequency');
ylabel('Filtered Output');
axis([-5000, 5000, 0, 2000]); %zooms in for clearer graph



zshift_fft = fftshift(z_fft);
outputshifted_fft = ifft(zshift_fft);

subplot(2,2,3);
plot(freq, abs(zshift_fft));
xlabel('Frequency');
ylabel('Filtered Output shifted');

subplot(2,2,4);
plot(abs(outputshifted_fft));
xlabel('Frequency');
ylabel('Filtered Shifted Output (IFFT)');

% %% Need to edit this to get output as a real dependency on time then sound
% %arrayfun(@toTime, A);
% 
% t = 0:length(x) -1;
% %sampling rate is 1/fs = Ts
% time = t./fs; % the . takes every element in fs and divides them by fs
% subplot(2,2,4);
% plot(time, abs(output));
% xlabel('Time domain');
% ylabel('Output in Time Domain');

end