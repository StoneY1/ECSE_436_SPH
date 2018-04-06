%% A2 Question 2g
clear
I = eye(4); %identity matrix
G_right = [1 1 1 0;1 1 0 1;1 0 1 1;0 1 1 1]; %right side of G matrix
G = horzcat(I,G_right); %generate G matrix
codebook = [0 0 0 0 0 0 0 0;mod([0 0 0 1]*G,2);mod([0 0 1 0]*G,2);mod([0 0 1 1]*G,2);mod([0 1 0 0]*G,2);mod([0 1 0 1]*G,2);mod([0 1 1 0]*G,2);mod([0 1 1 1]*G,2);mod([1 0 0 0]*G,2);mod([1 0 0 1]*G,2);mod([1 0 1 0]*G,2);mod([1 0 1 1]*G,2);mod([1 1 0 0]*G,2);mod([1 1 0 1]*G,2);mod([1 1 1 0]*G,2);mod([1 1 1 1]*G,2)];
%r = c + n
%r = [0.54, -0.12, 1.32, 0.41, 0.63, 1.25, 0.37, -0.02];

p1 = 1/2; %probability of a 1 for generation of m
%m = rand(1,8)<p1; %generate message vector
m = [ 0 1 0 0];
c = mod(m*G,2) %generate codeword c = mGc = [ 0 1 1 0 1 0 1 1 ];

%simulate AWGN noise
SNR = 50;
var = 0.5/(10^(SNR/10)); %variance of Gaussian noise positive
e_gauss = var*randn(1,8); %erasure channel
r = mod(abs(c +e_gauss),2); %input at receiver

min_indices = zeros(1,9);
j = 1;
word = zeros(1,8);
paths = zeros(1,4);

%% Must calculate all path lengths of first stage
%path_00
diff_00= r(1:2)-[0 0]; path_00 = diff_00*diff_00';
%path_11
diff_11 = r(1:2)-[1 1]; path_11 = diff_11*diff_11';
%path_10
diff_10 = r(1:2)-[1 0]; path_10 = diff_10*diff_10';
%path_01
diff_01 = r(1:2)-[0 1]; path_01 = diff_01*diff_01';

%% Add-compare-store path lengths of second stage
%path_000
p_000=zeros(1,2);
d_00 = r(3:4)-[0 0];
p_000(1) = d_00*d_00'+path_00;
d_11 = r(3:4)-[1 1];
p_000(2) = d_11*d_11'+path_11;
[path_000,i]=min(p_000);
min_indices(j) = i;
j = j+1;

%path_011
p_011=zeros(1,2);
d_00 = r(3:4)-[1 1];
p_011(1) = d_00*d_00'+path_00;
d_11 = r(3:4)-[0 0];
p_011(2) = d_11*d_11'+path_11;
[path_011,i]=min(p_011);
min_indices(j) = i;
j = j+1;

%path_110
p_110=zeros(1,2);
d_10 = r(3:4)-[0 1];
p_110(1) = d_10*d_10'+path_10;
d_01 = r(3:4)-[1 0];
p_110(2) = d_01*d_01'+path_01;
[path_110,i]=min(p_110);
min_indices(j) = i;
j = j+1;
%path_101
p_101=zeros(1,2);
d_10 = r(3:4)-[1 0];
p_101(1) = d_10*d_10'+path_10;
d_11 = r(3:4)-[0 1];
p_101(2) = d_01*d_01'+path_01;
[path_101,i]=min(p_101);
min_indices(j) = i;
j = j+1;

%% Third stage
%path_00
p_00=zeros(1,2);
d_000 = r(5:6)-[0 0];
p_00(1) = d_000*d_000'+path_000;
d_011 = r(5:6)-[1 1];
p_00(2) = d_011*d_011'+path_011;
[pathnew_00,i]=min(p_00);
min_indices(j) = i;
j = j+1;

%path_11
p_11=zeros(1,2);
d_000 = r(5:6)-[1 1];
p_11(1) = d_000*d_000'+path_000;
d_011 = r(5:6)-[0 0];
p_11(2) = d_011*d_011'+path_011;
[pathnew_11,i]=min(p_11);
min_indices(j) = i;
j = j+1;

%path_10
p_10=zeros(1,2);
d_110 = r(5:6)-[0 1];
p_10(1) = d_110*d_110'+path_110;
d_101 = r(5:6)-[1 0];
p_10(2) = d_101*d_101'+path_101;
[pathnew_10,i]=min(p_10);
min_indices(j) = i;
j = j+1;

%path_01
p_01=zeros(1,2);
d_110 = r(5:6)-[1 0];
p_01(1) = d_110*d_110'+path_110;
d_101 = r(5:6)-[0 1];
p_01(2) = d_101*d_101'+path_101;
[pathnew_01,i]=min(p_01);
min_indices(j) = i;
j = j+1;

%% Final stage
%path_1
d_1 = r(7:8)-[0 0];
paths(1)= d_1*d_1'+pathnew_00;

%path_2
d_2 = r(7:8)-[1 1];
paths(2)= d_2*d_2'+pathnew_11;

%path_3
d_3 = r(7:8)-[1 0];
paths(3)= d_3*d_3'+pathnew_10;

%path_4
d_4 = r(7:8)-[0 1];
paths(4)= d_4*d_4'+pathnew_01;

[min_path,i] = min(paths);
min_indices(j) = i;
j = j+1;

%% Find output bits of shortest path through trellis
%Need to start from End and work backwards; survivor paths to each state at
%each stage are stored in min_indices. Working backwards we can find the
%shortest path

next_ind = 0;
%Stage 4
if min_indices(9) == 1
    word(7:8) = [0 0];
    next_ind = 5;
elseif min_indices(9) == 2
    word(7:8) = [1 1];
    next_ind = 6;
elseif min_indices(9) == 3
    word(7:8) = [1 0];
    next_ind = 7;
else
    word(7:8) = [0 1];
    next_ind = 8;
end

%Stage 3
if next_ind == 5
    if min_indices(next_ind) == 1
        next_ind = 1;
        word(5:6) = [0 0];
    else
        next_ind = 2;
        word(5:6) = [1 1];
    end
elseif next_ind == 6
    if min_indices(next_ind) == 1
        next_ind = 1;
        word(5:6) = [1 1];
    else
        next_ind = 2;
        word(5:6) = [0 0];
    end
elseif next_ind == 7
    if min_indices(next_ind) == 1
        next_ind = 3;
        word(5:6) = [0 1];
    else
        next_ind = 4;
        word(5:6) = [1 0];
    end
else
    if min_indices(next_ind) == 1
        next_ind = 3;
        word(5:6) = [1 0];
    else
        next_ind = 4;
        word(5:6) = [0 1];
    end
end

%Stage 2
if next_ind == 1
    if min_indices(next_ind) == 1
        next_ind = 1;
        word(3:4) = [0 0];
    else
        next_ind = 2;
        word(3:4) = [1 1];
    end
elseif next_ind == 2
    if min_indices(next_ind) == 1
        next_ind = 1;
        word(3:4) = [1 1];
    else
        next_ind = 2;
        word(3:4) = [0 0];
    end
elseif next_ind == 3
    if min_indices(next_ind) == 1
        next_ind = 3;
        word(3:4) = [0 1];
    else
        next_ind = 4;
        word(3:4) = [1 0];
    end
else
    if min_indices(next_ind) == 1
        next_ind = 3;
        word(3:4) = [1 0];
    else
        next_ind = 4;
        word(3:4) = [0 1];
    end
end

%First stage
if next_ind == 1
    word(1:2) = [0 0];
elseif next_ind == 2
    word(1:2) = [1 1];
elseif next_ind == 3
    word(1:2) = [1 0];
else
    word(1:2) = [0 1];
end



fprintf('shortest path through trellis has a length of: ');
min_path

fprintf('originally transmitted codeword is most likely: ');
word
