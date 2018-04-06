%ECSE 436 Jessica Udo, Stone Yun
%question 2
clear;
%acquiring signal data
f = 16000; %%declared playback frequency
h = audioread('h.wav'); %%reading in the impulse response and speech recording
SON(x, f) = audioread('speech.wav'); 
sound(x);
%%Part (a)
plot(h); %%plots sample number vs amplitude of the impulse response
xlabel('Time');
ylabel('h(t)');
title('Plot of the impulse response for the channel');

%%Part (b)
%sound(x,f); %%listening to original speech file
convhx = conv(h,x); %%convolving the two signals together
%sound(convhx);

%%Part (c)
h1 = h; %%Create new matrix of the same size
N = 3000;
for n = N+1:length(h) %%populating the new matrix with time shifted entries
    h1(n-N) = h(n); 
end;
convh1 = conv(h1,x);
%sound(convh1,f); %%listening to the new signal

%%Part (d)
%xreverse = flipud(x); %%Use MatLab function to flip the matrix upside down
%sound(xreverse,f);

%%Part(e)
% sound(x,13000);
% sound(x,14500);
% sound(x,17000); %%playback at various sampling speeds etc etc;
% sound(x,18500); %%playback at various sampling speeds etc etc;
% sound(x,20000);

%Part(f)
samples = [ 2 3 4 5 10]; %create an array for the sub-sampling frequencies

for i = 1:5 %to go through the required aliasing points
    n = samples(i);
    a_x = x (1:n:end); %aliased speech is the original sound with each n-th smaple removed
    %goes through x from 1 to the end and takes out the n-th sample
    f = 16000/n; %adjust frequency so that the sound plays at the same speed
    %sound(a_x, f); %play aliased sound
    stem(a_x) %connects all points to make smooth curve from distinct sub-samples to play over
    pause(8);
     clear sound %this stops the signal from playing on
end

%part (g)
maximum = 0.5; %max(y)
minimum = -0.5; %min(y)

for q = [16 8 4 2 1]
    partition = [minimum+(1/q):(1/q):maximum];
    codebook = [minimum:(1/q): maximum];
    [index, quantus] = quantiz(x, partition, codebook);
    stem(quantus) 
    %sound(quantus, 16000)
    pause(8)
end

