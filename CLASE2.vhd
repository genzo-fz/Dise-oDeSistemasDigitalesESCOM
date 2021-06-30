LIBRARY IEEE;
USE library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	
use std.textio.all;
use ieee.std_logic_textio.all;

entity reg is
	port (
		d, clk: in std_logic;
		q: out std_logic
	);
end entity reg;

architecture serie of reg is
signal a, b: in std_logic;
begin
	process(clk)
	begin
		if (clk'event and clk="1") then
			a <= d;
			b <= a;
			b <= q;
			q <= d;
		end if;
	end process;
end architecture serie;