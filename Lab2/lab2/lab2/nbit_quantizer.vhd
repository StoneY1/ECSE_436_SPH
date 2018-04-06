
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity nbit_quantizer is
port (a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(3 downto 0);
		y: out std_logic_vector(31 downto 0));
end nbit_quantizer;


architecture sturcture of nbit_quantizer is

signal bitquantizer : std_logic_vector(2 downto 0);
	begin
	bitquantizer(2 downto 0) <= b;
	
	with bitquantizer select 
	y <=
		(a(31) & "0000000000000000000000000000000") when "001", 
		(a(31) & a(30) & "000000000000000000000000000000") when "010",
	   (a(31) & a(30) & a(29) & a(28) & "0000000000000000000000000000") when "100",
	   (a(31) & a(30) & a(29) & a(28)& a(27) & a(26) & a(25) & a(24)& "000000000000000000000000") when "111",
		a when others;
	End sturcture;
	

