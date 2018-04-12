function [y]=FFT_16(x)
    % initialization
    x1 = zeros(16,1);
    x2 = zeros(16,1);
    x3 = zeros(16,1);
    x4 = zeros(16,1);
    y  = zeros(16,1);
    
    %stage 1
    for ind = 0:7
        twiddle1=exp(-2*pi*j*ind*1/16);
        x1(ind+1) = x(ind+1)  + x(ind+9);
        x1(ind+9) = (x(ind+1) - x(ind+9))*twiddle1;
    end
    
    %stage 2
    for ind = 0:3
        twiddle2=exp(-2*pi*j*ind*1/8);
        x2(ind+1)  = x1(ind+1)  + x1(ind+5);
        x2(ind+5)  = (x1(ind+1) - x1(ind+5))*twiddle2;
        x2(ind+9)  = (x1(ind+9) + x1(ind+13));
        x2(ind+13)  = (x1(ind+9) - x1(ind+13))*twiddle2;
    end
    
    %stage 3
    for ind = 0:1
        twiddle3=exp(-2*pi*j*ind*1/4);
        x3(ind+1)  = x2(ind+1)  + x2(ind+3);
        x3(ind+3)  = (x2(ind+1) - x2(ind+3))*twiddle3;
        x3(ind+5)  = (x2(ind+5) + x2(ind+7));
        x3(ind+7)  = (x2(ind+5) - x2(ind+7))*twiddle3;
        x3(ind+9)  = (x2(ind+9) + x2(ind+11));
        x3(ind+11)  = (x2(ind+9) - x2(ind+11))*twiddle3;
        x3(ind+13)  = (x2(ind+13) + x2(ind+15));
        x3(ind+15)  = (x2(ind+13) - x2(ind+15))*twiddle3;
    end
    
    %stage 4
    x4(1) = x3(1)  + x3(2);
    x4(2) = x3(1)  - x3(2);
    x4(3) = x3(3)  + x3(4);
    x4(4) = x3(3)  - x3(4);
    x4(5) = x3(5)  + x3(6);
    x4(6) = x3(5)  - x3(6);
    x4(7) = x3(7)  + x3(8);
    x4(8) = x3(7)  - x3(8);
    x4(9) = x3(9)  + x3(10);
    x4(10) = x3(9)  - x3(10);
    x4(11) = x3(11)  + x3(12);
    x4(12) = x3(11)  - x3(12);
    x4(13) = x3(13)  + x3(14);
    x4(14) = x3(13)  - x3(14);
    x4(15) = x3(15)  + x3(16);
    x4(16) = x3(15)  - x3(16);
    
    %reorder
    y(1) = x4(1);
    y(2) = x4(9);
    y(3) = x4(5);
    y(4) = x4(13);
    y(5) = x4(3);
    y(6) = x4(11);
    y(7) = x4(7);
    y(8) = x4(15);
    y(9) = x4(2);
    y(10) = x4(10);
    y(11) = x4(6);
    y(12) = x4(14);
    y(13) = x4(4);
    y(14) = x4(12);
    y(15) = x4(8);
    y(16) = x4(16);
end
