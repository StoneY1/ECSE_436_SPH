%Jessica Udo, Stone Yun
%FFT using Decimation in Time Radix 2 
function [XkA] = my_FFT(x)
if (numel(x)~= 8)
    error('FFT code only works for sequence length = 8');
end
%only works if N = 2^k
%Divide input into an even and odd part
ip_odd_final = x(1:2:end);% Extract all the odd elements
ip_even_final = x(2:2:end);


N = numel(ip_even_final); %returns the number of elements n in array p

%X = zeros(size(x_evn));
%Xk_final=[];

exp = 2.718281828;

Xk0=ip_even_final(1)*exp^-((0+1i*2*pi*1*0)/N)+ip_even_final(2)*exp^-((0+1i*2*pi*2*0)/N)+ip_even_final(3)*exp^-((0+1i*2*pi*3*0)/N)+ip_even_final(4)*exp^-((0+1i*2*pi*4*0)/N);

Xk1 =ip_even_final(1)*exp^-((0+1i*2*pi*1*1)/N)+ip_even_final(2)*exp^-((0+1i*2*pi*2*1)/N)+ip_even_final(3)*exp^-((0+1i*2*pi*3*1)/N)+ip_even_final(4)*exp^-((0+1i*2*pi*4*1)/N);

Xk2 =ip_even_final(1)*exp^-((0+1i*2*pi*1*2)/N)+ip_even_final(2)*exp^-((0+1i*2*pi*2*2)/N)+ip_even_final(3)*exp^-((0+1i*2*pi*3*2)/N)+ip_even_final(4)*exp^-((0+1i*2*pi*4*2)/N);

Xk3 =ip_even_final(1)*exp^-((0+1i*2*pi*1*3)/N)+ip_even_final(2)*exp^-((0+1i*2*pi*2*3)/N)+ip_even_final(3)*exp^-((0+1i*2*pi*3*3)/N)+ip_even_final(4)*exp^-((0+1i*2*pi*4*3)/N);

Xk_even=[Xk0 Xk1 Xk2 Xk3];
disp('DFT of Even part')
disp(Xk_even)

% x_odd= ip_odd_final;
% N=length(x_odd);
% X=zeros(size(x_odd));
% %Xk_final=[];


disp('******************************************************************************')

disp('DFT of Odd part') % Below code is uses for finding DFT of Odd part

Xk4 =ip_odd_final(1)*exp^-((0+1i*2*pi*1*0)/N)+ip_odd_final(2)*exp^-((0+1i*2*pi*2*0)/N)+ip_odd_final(3)*exp^-((0+1i*2*pi*3*0)/N)+ip_odd_final(4)*exp^-((0+1i*2*pi*4*0)/N);

Xk5 =ip_odd_final(1)*exp^-((0+1i*2*pi*1*1)/N)+ip_odd_final(2)*exp^-((0+1i*2*pi*2*1)/N)+ip_odd_final(3)*exp^-((0+1i*2*pi*3*1)/N)+ip_odd_final(4)*exp^-((0+1i*2*pi*4*1)/N);

Xk6 =ip_odd_final(1)*exp^-((0+1i*2*pi*1*2)/N)+ip_odd_final(2)*exp^-((0+1i*2*pi*2*2)/N)+ip_odd_final(3)*exp^-((0+1i*2*pi*3*2)/N)+ip_odd_final(4)*exp^-((0+1i*2*pi*4*2)/N);

Xk7 =ip_odd_final(1)*exp^-((0+1i*2*pi*1*3)/N)+ip_odd_final(2)*exp^-((0+1i*2*pi*2*3)/N)+ip_odd_final(3)*exp^-((0+1i*2*pi*3*3)/N)+ip_odd_final(4)*exp^-((0+1i*2*pi*4*3)/N);


Xk_odd=[Xk4 Xk5 Xk6 Xk7];
disp(Xk_odd)

% This code is used for finding the value of Omega.

Nn=8;

W0 =exp^-((0+1i*2*pi*0)/Nn);
W1 =exp^-((0+1i*2*pi*1)/Nn);
W2 =exp^-((0+1i*2*pi*2)/Nn);
W3 =exp^-((0+1i*2*pi*3)/Nn);
W4 =exp^-((0+1i*2*pi*4)/Nn);
W5 =exp^-((0+1i*2*pi*5)/Nn);
W6 =exp^-((0+1i*2*pi*6)/Nn);
W7 =exp^-((0+1i*2*pi*7)/Nn);

%This is the last step of coding uses for calculating DFT

X0 = Xk0+Xk4*W0;
X1 = Xk1+Xk5*W1;
X2 = Xk2+Xk6*W2;
X3 = Xk3+Xk7*W3;
X4 = Xk4+Xk0*W4;
X5 = Xk5+Xk1*W5;
X6 = Xk6+Xk2*W6;
X7 = Xk7+Xk3*W7;

disp('*****************************************************************************')

disp('End result of Radix_2_fft')
XkA = [ X0; X1; X2; X3; X4; X5; X6; X7;];
disp(XkA) % Use for display result

disp('*****************************************************************************')

end
% 
% if N>=8
%     Xp = my_FFT(x_odd);
%     Xpp = my_FFT(x_even);
%     X = zeros(N,1);
%     Wn = exp(-1i*2*pi*((0:N/2-1)')/N);
%     tmp = Wn .* Xpp;
%     X = [(Xp + tmp);(Xp -tmp)];
%     
% else
%     switch N
%         case 2
%             X = [1 1;1 -1]*x;
%         case 4
%             X = [1 0 1 0; 0 1 0 -1i; 1 0 -1 0;0 1 0 1i]*[1 0 1 0;1 0 -1 0;0 1 0 1;0 1 0 -1]*x;
%         otherwise
%             error('N not correct.');
%     end
% end

% mm=[];
% A=10;
% fs=1000;
% Ts=1/fs;
% t=(1:1000)*Ts;
% y=10*sin(2*pi*200*t)+5*sin(2*pi*400*t)+12*sin(2*pi*300*t);
% N=length(t);
% for(k=1:N)
%     for(n=1:N)
%         y1(n)=y(n).*exp(-j*2*pi*((-N/2)+n-1)*((-N/2)+k-1)/N);
%     end
%     mm=[mm sum(y1)];
% end
%
% length(mm);
% f=fs.*(-N/2:N/2-1)/N;
% figure(1)
% plot(f,2*abs(mm)/N);
% title('Frequency spectrum for given signal without FFT biltin function');
% xlabel('Frequency(Hz)');
% ylabel('Amplitude(volt)');


% %XXXXXXXXXXXXXXXXXXXXXXXXXX FFT with biltin function XXXXXXXXXXXXXXXXXXXXXX
% mm=[];
% A=10;
% fs=1000;
% Ts=1/fs;
% t=(1:1000)*Ts;
% y=10*sin(2*pi*200*t)+5*sin(2*pi*400*t)+12*sin(2*pi*300*t);
% N=length(t);
% N=length(t);
% yy=fft(y);
% yyy=fftshift(yy);
% f=fs.*(-N/2:N/2-1)/N;
% figure(2)
% plot(f,(2*abs(yyy)/N));
% title('Frequency spectrum for given signal with FFT biltin function (BF)');
% xlabel('Frequency(Hz)');
% ylabel('Amplitude(volt)');


% %XXXXXXXXXXXXXXXXX FFT with biltin function and zero padding XXXXXXXXXXXXX
% %mm=[];
% %A=10;
% fs=1000;
% Ts=1/fs;
% t=(1:1000)*Ts;
% y=10*sin(2*pi*200*t)+5*sin(2*pi*400*t)+12*sin(2*pi*300*t);
% N= 2^nextpow2(1000);
%
% yy =fft(y,N);
% yyy=fftshift(yy);
% f=fs.*(-N/2:N/2-1)/N;
% figure(3)
% plot(f,(2*abs(yyy)/N));
% title('Frequency spectrum for given signal with FFT(BF)and zero padding');
% xlabel('Frequency(Hz)');
% ylabel('Amplitude(volt)');
