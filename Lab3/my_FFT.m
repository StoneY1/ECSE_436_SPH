% --- Radix-2 recursive FFT
 
function y = my_FFT(x)
 
N = length(x);
W = exp(-2 * pi * 1i / N) .^ (0 : N / 2 - 1);
 
if N == 1
    y = x;
else
    y_top       = my_FFT(x(1: 2 : (N - 1)));
    y_bottom    = my_FFT(x(2 : 2 : N));
    z           = W .* y_bottom;
    y           = [y_top + z, y_top - z];
end
