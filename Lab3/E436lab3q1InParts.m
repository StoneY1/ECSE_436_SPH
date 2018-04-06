%% Lab 3 question 1c - Corrupt Signal with Jamming signal 
clear;
%Jamming Signal
[x,fs] = audioread('speech.wav');
subplot(3,2,1)
%plot(x);
%xlabel('Time');
%ylabel('Input');
%title('Plot of x(t)');

% TIME SPECIFICATION
Fs = 16000;                  % samples per second
dt = 1/Fs;                   % seconds per sample
StopTime = 0.25;             % seconds
t = (0:dt:StopTime-dt)';     % seconds
%Sine wave:
Fc = 60; %confirm fc                    % hertz
carrier = cos(2*pi*Fc*t);
% Plot the signal versus time:
% figure;
% subplot(3,2,2)
% %stem(n,carrier);
% plot(t,carrier);
% xlabel('Time');
% ylabel('Carrier');
% title('Plot of cos(wct) vs time');
% zoom xon;

%% Now we convolve
time = t./fs; % the . takes every element in fs and divides them by fs
mod1 = x'.*carrier;
 subplot(3,2,3);
 plot(time,mod1)
 axis ([0, 2, -0.5, 0.5]);  %zooms in for clearer graph
xlabel('time (s)');
 ylabel('modulated speech');
 title('w_c = 100,000 Hz, suppressed carrier');
 

% x_fft = fft(x);
% car_fft = fft(carrier);
% 
% 
% y1 = conv(abs(x_fft,car_fft));
% %y1 = x * carrier';
% subplot(3,2,3)
% plot(y1);
% xlabel('Time');
% ylabel('Input with carrier');
% title('y1Plot of x(t)cos(wct)');



% 
% fjam=4; %confirm this ! fc = wc right ?
% J = 200;
% jn=0:1/fjam:11/fjam;
% jamming_signal = J * sin(2*pi*jn);
% subplot(3,2,4)
% stem(jn,jamming_signal);
% xlabel('Time');
% ylabel('Jsin(2*pi*jn)');
% title('Plot of the Jsin(2*pi*jn)');
% 
% y2 = conv(jamming_signal,carrier);
% subplot(3,2,5)
% plot(y2);
% xlabel('Time');
% ylabel('Jamming Signal');
% title('Plot of [Jsin(2pi400t)]cos(wct)');
% 
% %signal = y1 + y2;
% %Jamming signal is implemented correctly
% 
% % subplot(3,2,6)
% % plot(signal);
% % xlabel('Time');
% % ylabel('Input');
% % title('Plot of x(t)cos(wct)+[Jsin(2pi400t)]cos(wct)');
% %%
% %At receiving end, need to tune the volume down to reduce the amplitude,
% %but this also reduces x(t) such that it becomes inaudible.
% %Need to find J such that starts to become inaudible
% 
% 
