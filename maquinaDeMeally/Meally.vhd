library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Meally is
	port( e, clk:		in std_logic;
			clk_div:		inout std_logic:='0';
			q:				inout std_logic_vector(1 downto 0);
			a, b:			out std_logic
	);
end Meally;
	
architecture Behavioral of Meally is
signal n: std_logic_vector(1 downto 0);

constant max: integer:= 5000000;
signal cont: integer range 0 to max;

begin
	------------------------------------
	reloj: process(clk)begin
		if(rising_edge(clk))then
			if(cont<max)then
				cont<=cont+1;
			else
				cont<=0;
				clk_div<=not clk_div;
			end if;
		end if;
	end process reloj;
	-----------------------------------
	estados: process(clk_div)begin
			if(rising_edge(clk_div)) then
				if(e='1') then
					if(n="00") then
						n<="00";
						a<='0';
						b<='0';
					elsif(n="01") then
						n<="00";
						a<='1';
						b<='1';
					elsif(n="10") then
						n<="11";
						a<='1';
						b<='0';
					elsif(n="11") then
						n<="00";
						a<='1';
						b<='1';
					end if;
				else
					if(n="00") then
						n<="01";
						a<='0';
						b<='1';
					elsif(n="01") then
						n<="10";
						a<='0';
						b<='0';
					elsif(n="10") then
						n<="11";
						a<='1';
						b<='0';
					elsif(n="11")then
						n<="10";
						a<='0';
						b<='0';
					end if;
				end if;
			end if;
	end process estados;
	q<=not n;	
end Behavioral;