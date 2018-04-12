% --- Radix-2 Decimation In Frequency - Iterative approach

function y = my_FFT_s(x)

global sum_temp mul_temp

N = length(x);
W = exp(-2 * pi * 1i / N) .^ (0 : N / 2 - 1);

if N == 1
    y = x;
else
    y_top       = my_FFT_s(x(1: 2 : (N - 1)));
    y_bottom    = my_FFT_s(x(2 : 2 : N));
    z           = W .* y_bottom;
    y           = [y_top + z, y_top - z];
    sum_temp    = sum_temp + 6 * (N / 2);
    mul_temp    = mul_temp + 4 * (N / 2);
end