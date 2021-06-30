use library ieee;
use ieee.std_logic_1164.all;
use iee.std_logic_unsigned.all;
use ieee.numeric_std.all;	
use std.textio.all;
use ieee.std_logic_textio.all;

entity september is
	port (
		a: in std_logic;
		b: in std_logic;
		c: in std_logic);
	
end entity september;

ARCHITECTURE Behavioral OF september is
begin
	a <= a or b;
end Behavioral;