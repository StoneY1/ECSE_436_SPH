%% Q2a - Hamming code
clear
I = eye(4); %identity matrix
G_right = [1 1 1 0;1 1 0 1;1 0 1 1;0 1 1 1]; %right side of G matrix
G = horzcat(I,G_right); %generate G matrix
codebook = [0 0 0 0 0 0 0 0;mod([0 0 0 1]*G,2);mod([0 0 1 0]*G,2);mod([0 0 1 1]*G,2);mod([0 1 0 0]*G,2);mod([0 1 0 1]*G,2);mod([0 1 1 0]*G,2);mod([0 1 1 1]*G,2);mod([1 0 0 0]*G,2);mod([1 0 0 1]*G,2);mod([1 0 1 0]*G,2);mod([1 0 1 1]*G,2);mod([1 1 0 0]*G,2);mod([1 1 0 1]*G,2);mod([1 1 1 0]*G,2);mod([1 1 1 1]*G,2)];
r = [0.54, -0.12, 1.32, 0.41, 0.63, 1.25, 0.37, -0.02];
%% Exhaustive search
v = 0;
min = 100;
c_i = zeros(1,8);
for i = 1:16
    c_i = codebook(i,:);
    v = (r-c_i)*(r-c_i)'; %Calculating square Euclidean distance of received vector from all 16 possible codewords
    if v < min
        min = v;
        min_pos = i;
    end
end

%output
likeliest_codeword = codebook(min_pos,:); %Reporting codeword with smalled square Euclidean distance from vector r
fprintf('Most likely codeword is: ');
likeliest_codeword