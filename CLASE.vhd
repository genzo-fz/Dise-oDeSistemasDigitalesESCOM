LIBRARY IEEE;
USE library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	
use std.textio.all;
use ieee.std_logic_textio.all;

entity reg is
	port (
		clk, clr, es: in bit;
		oper: in bit_vector(1 downto 0);
		d: in bit_vector(6 downto 0);
		q: inout bit_vector(6 downto 0)
	);
end entity reg;

architecture areg of reg is
begin
	reg: process(clk, clr);
	begin
	if (clr="1") then
		q<="000000";
	elsif (clk'event and clk="1") then
		case oper is
			when "00" => q <= q;
			when "01" => q <= d;
			when "10" => 
				q <= q sll 1;
				q(0) <= es;
			when others =>
				q <= q srl 1;
				q(6) <= es;
		end case;		
	end if;
end architecture reg;