library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;
--use work.fft_package.all;
use work.definitions.all;

entity FFT_16 is

Port (x : in signed_vector;
	y_R, y_i : out signed_vector);

end FFT_16;
	
architecture Behavioral of FFT_16 is
signal x1R, x1I, x2R, x2I, x3R, x3I, x4R, x4I : signed_vector := (("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000"),
("0000000000000000")
);
signal twiddleR, twiddleI : signed(15 downto 0) := "0000000000000000";


constant w_R : signed_vector := (
("0100000000000000"),
("0011101100100001"), 
("0010110101000001"),
("0001100001111110"),
("0000000000000000"),
("1110011110000010"),
("1101001010111111"),
("1100010011011111"),
("1100000000000000"),
("1100010011011111"),
("1101001010111111"),
("1110011110000010"),
("0000000000000000"),
("0001100001111110"),
("0010110101000001"),
("0011101100100001")
);

constant w_I : signed_vector := (
("0000000000000000"),
("1110011110000010"),
("1101001010111111"),
("1100010011011111"),
("1100000000000000"),
("1100010011011111"),
("1101001010111111"),
("1110011110000010"),
("0000000000000000"),
("0001100001111110"),
("0010110101000001"),
("0011101100100001"),
("0100000000000000"),
("0011101100100001"),
("0010110101000001"),
("0001100000111110")
);

begin
FFT_process : process(x) begin
for i in 0 to 3 loop
	if i = 0 then
		for ind in 0 to 7 loop --first stage of FFT 16 butterfly
       			twiddleR <= w_R(ind);
			twiddleI <= w_I(ind);
        		x1R(ind) <= x(ind) + x(ind+8);
        		x1R(ind+8) <= (x(ind) - x(ind+8))*twiddleR; --real and imaginary componenets need to be calculated separately now
			x1I(ind+8) <= (x(ind) - x(ind+8))*twiddleI;
		end loop;
	end if;
	if i = 1 then
		for ind in 0 to 3 loop
       			 twiddleR <= w_R(2*ind);
			 twiddleI <= w_I(2*ind);
       			 x2R(ind) <= x1R(ind) + x1R(ind+4);
			 x2I(ind+1) <= x1I(ind+1) + x1I(ind+4);
       			 x2R(ind+4) <= (x1R(ind+1) - x1R(ind+4))*twiddleR - (x1I(ind+1) - x1I(ind+5))*twiddleI; --perform complex multiplication manually
			 x2I(ind+4) <= (x1I(ind+1)-x1I(ind+4))*twiddleR + (x1R(ind+1) - x1R(ind+5))*twiddleI;
       			 x2R(ind+8) <= (x1R(ind+8) + x1R(ind+12));	
			 x2I(ind+8) <= (x1I(ind+8) + x1I(ind+12));
       			 x2R(ind+12) <= (x1R(ind+8) - x1R(ind+12))*twiddleR - (x1I(ind+8) - x1I(ind+12))*twiddleI;
			 x2I(ind+12) <= (x1R(ind+8) - x1R(ind+12))*twiddleI + (x1I(ind+8) - x1I(ind+12))*twiddleR;
   		 end loop;
  	end if;
	if i = 2 then
		for ind in 0 to 1 loop
        		twiddleR <= w_R(4*ind);
			twiddleI <= w_I(4*ind);
        		x3R(ind) <= x2R(ind)  + x2R(ind+2);
			x3I(ind) <= x2I(ind+1)  + x2I(ind+2);
        		x3R(ind+2) <= (x2R(ind) - x2R(ind+2))*twiddleR - (x2I(ind) - x2I(ind+2))*twiddleI;
			x3I(ind+2) <= (x2R(ind) - x2R(ind+2))*twiddleI + (x2I(ind) - x2I(ind+2))*twiddleR;
        		x3R(ind+3) <= (x2R(ind+4) + x2R(ind+6));
			x3I(ind+3) <= (x2I(ind+4) + x2I(ind+6));
        		x3R(ind+6) <= (x2R(ind+4) - x2R(ind+6))*twiddleR - (x2I(ind+4) - x2I(ind+6))*twiddleI;
			x3I(ind+6) <= (x2R(ind+4) - x2R(ind+6))*twiddleI + (x2I(ind+4) - x2I(ind+6))*twiddleR;
        		x3R(ind+8) <= (x2R(ind+8) + x2R(ind+10));
			x3I(ind+8) <= (x2I(ind+8) + x2I(ind+10));
        		x3R(ind+10) <= (x2R(ind+8) - x2R(ind+10))*twiddleR - (x2I(ind+8) - x2I(ind+10))*twiddleI;
			x3I(ind+10) <= (x2R(ind+8) - x2R(ind+10))*twiddleI + (x2I(ind+8) - x2I(ind+10))*twiddleR;
        		x3R(ind+12) <= (x2R(ind+12) + x2R(ind+14));
			x3I(ind+12) <= (x2I(ind+12) + x2I(ind+14));
        		x3R(ind+14) <= (x2R(ind+12) - x2R(ind+14))*twiddleR - (x2I(ind+12) - x2I(ind+14))*twiddleI;
			x3I(ind+14) <= (x2R(ind+12) - x2R(ind+14))*twiddleI + (x2I(ind+12) - x2I(ind+14))*twiddleR;
   		end loop;
	end if;
	if i = 3 then
		x4R(0) <= x3R(0) + x3R(1);
		x4I(0) <= x3I(0) + x3I(1);
  		x4R(1) <= x3R(0) - x3R(1);
		x4I(1) <= x3I(0) - x3I(1);
    		x4R(2) <= x3R(2) + x3R(3);
		x4I(2) <= x3I(2) + x3I(3);
    		x4R(3) <= x3R(2) - x3R(3);
		x4I(3) <= x3I(2) - x3I(3);
    		x4R(4) <= x3R(4) + x3R(5);
		x4I(4) <= x3I(4) + x3I(5);
    		x4R(5) <= x3R(4) - x3R(5);
		x4I(5) <= x3I(4) - x3I(5);
    		x4R(6) <= x3R(6) + x3R(7);
		x4I(6) <= x3I(6) + x3I(7);
    		x4R(7) <= x3R(6) - x3R(7);
		x4I(7) <= x3I(6) - x3I(7);
    		x4R(8) <= x3R(8) + x3R(9);
		x4I(8) <= x3I(8) + x3I(9);
    		x4R(9) <= x3R(8) - x3R(9);
		x4I(9) <= x3I(8) - x3I(9);
    		x4R(10) <= x3R(10) + x3R(11);
		x4I(10) <= x3I(10) + x3I(11);
    		x4R(11) <= x3R(10) - x3R(11);
		x4I(11) <= x3I(10) - x3I(11);
    		x4R(12) <= x3R(12) + x3R(13);
		x4I(12) <= x3I(12) + x3I(13);
    		x4R(13) <= x3R(12) - x3R(13);
		x4I(13) <= x3I(12) - x3I(13);
    		x4R(14) <= x3R(14) + x3R(15);
		x4I(14) <= x3I(14) + x3I(15);
    		x4R(15) <= x3R(14) - x3R(15);
		x4I(15) <= x3I(14) - x3I(15);
	end if;
end loop;
--re-order coefficients
--reorder
    y_R(0) <= x4R(0);
    y_I(0) <= x4I(0);
    y_R(1) <= x4R(8);
    y_I(1) <= x4I(8);
    y_R(2) <= x4R(4);
    y_I(2) <= x4I(4);
    y_R(3) <= x4R(12);
    y_I(3) <= x4I(12);
    y_R(4) <= x4R(2);
    y_I(4) <= x4I(2);
    y_R(5) <= x4R(10);
    y_I(5) <= x4I(10);
    y_R(6) <= x4R(8);
    y_I(6) <= x4I(8);
    y_R(7) <= x4R(14);
    y_I(7) <= x4I(14);
    y_R(8) <= x4R(1);
    y_I(8) <= x4I(1);
    y_R(9) <= x4R(11);
    y_I(9) <= x4I(11);
    y_R(10) <= x4R(5);
    y_I(10) <= x4I(5);
    y_R(11) <= x4R(13);
    y_I(11) <= x4I(13);
    y_R(12) <= x4R(3);
    y_I(12) <= x4I(3);
    y_R(13) <= x4R(11);
    y_I(13) <= x4I(11);
    y_R(14) <= x4R(7);
    y_I(14) <= x4I(7);
    y_R(15) <= x4R(15);
    y_I(15) <= x4I(15);

end process;

end Behavioral;