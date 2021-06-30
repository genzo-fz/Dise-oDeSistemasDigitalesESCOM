library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Jonhson is
	port(
		clk: 	in		std_logic;
		clkD:	inout std_logic :='0';
		disp: out 	std_logic_vector(0 to 7);
		act:	out	std_logic;
		q: 	inout bit_vector(0 to 3)
	);
end Jonhson;

architecture Behavioral of Jonhson is
	constant maxC: integer:=1000000;
	signal 	cont: integer range 0 to maxC;
	
	constant d0: std_logic_vector := "00000011";
	constant d1: std_logic_vector := "10011111";
	constant d2: std_logic_vector := "00100101";
	constant d3: std_logic_vector := "00001101";
	constant d4: std_logic_vector := "10011001";
	constant d5: std_logic_vector := "01001001";
	constant d6: std_logic_vector := "01000001";
	constant d7: std_logic_vector := "00011111";

	signal	 edo: integer range 0 to 7:=0;
	constant std0: bit_vector:="1111";
	constant std1: bit_vector:="0111";
	constant std2: bit_vector:="0011";
	constant std3: bit_vector:="0001";
	constant std4: bit_vector:="0000";
begin
	----------------------------------------reloj
	reloj: process(clk) begin
		if (rising_edge(clk)) then
			if(cont<maxC)then
				cont<=cont+1;
			else
				clkD<=not clkD;
				cont<=0;
			end if;
		end if;
	end process reloj;
	----------------------------------------
	----------------------------------------contador
	contador: process(clkD)begin
		if (rising_edge(clkD))then
			if	  (edo=0)then
				q<=std0; act<='0';
				disp<=d0;
			elsif(edo=1)then
				q<=std1;
				disp<=d1;
			elsif(edo=2)then
				q<=std2;
				disp<=d2;
			elsif(edo=3)then
				q<=std3;
				disp<=d3;
			elsif(edo=4)then
				q<=std4;
				disp<=d4;
			elsif(edo=5)then
				q<=not std1;
				disp<=d5;
			elsif(edo=6)then
				q<=not std2;
				disp<=d6;
			elsif(edo=7)then
				q<=not std3;
				disp<=d7;
				edo<=0;
			end if;
			edo<=edo+1;
		end if;
	end process contador;
	----------------------------------------
end Behavioral;
