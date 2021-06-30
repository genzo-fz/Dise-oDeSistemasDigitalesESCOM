library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity F is
  Port (	clk : 			in  STD_LOGIC;
			clk_div: 		inout STD_LOGIC := '0';

			cls : 			in STD_LOGIC;
			in1 :				in STD_LOGIC;
			in2 :				in STD_LOGIC;
			sel : 			in  STD_LOGIC_VECTOR (1 downto 0);
			qsalida : 		out  STD_LOGIC;
			qsalidan : 		out  STD_LOGIC);
end F;

architecture Behavioral of F is

constant contador_max: integer := 5000000;
signal contador: integer range 0 to contador_max;

signal td, tt, tsr, tjk, tq: std_logic;
begin
  -------------------------------------------------------------------------------CLK
	clk_gen: process(clk) begin
		if(rising_edge(clk))then
			if(contador<contador_max) then
				contador<=contador+1;
			else
				contador<=0;
				clk_div<=not clk_div;
			end if;
		end if;
	end process clk_gen;
  -------------------------------------------------------------------------------FLIPFLOP D
	ftd: process (clk_div, cls) begin
		if(cls = '0') then
			td <='0';
		elsif (rising_edge(clk_div)) then
				td <= in1;
		else
				td <= td;
		end if;
	end process ftd;
  -------------------------------------------------------------------------------FLIPFLOP T
	ftt: process (clk_div, cls) begin
		if(cls = '0') then
			tt <='0';
		elsif (rising_edge(clk_div)) then
			if(in1 = '1') then
				tt <= not tt;
			else
				tt <= tt;
			end if;
		end if;
	end process ftt;
  -------------------------------------------------------------------------------FLIPFLOP SR
	ftsr: process (clk_div, cls) begin
		if(cls = '0') then
			tsr <='0';
		elsif(rising_edge(clk_div)) then
			if(in1='1' and in2='1') then 
				tsr<=tsr;
			elsif(in1 = '1' and in2='0') then----set
				tsr<='1';
			elsif (in2 = '1' and in1='0') then--reset
				tsr<='0';				
			end if;
		end if;
	end process ftsr;
  -------------------------------------------------------------------------------FLIPFLOP JK 
	ftjk: process (clk_div, cls) begin
		if(cls = '0') then
			tjk <= '0';
		elsif(rising_edge(clk_div)) then 
			if (in1/=in2) then
				tjk <= in1;
			elsif(in1='1' and in2='1') then
				tjk <= not tjk;
			else
				tjk <= tjk;
			end if;
		end if;
	end process ftjk;
  -------------------------------------------------------------------------------SELECTOR
  
	tq <= 		td when 		sel = "00" 
			else 	tt when 	sel = "01" 
			else 	tsr when 	sel = "10" 
			else 	tjk when 	sel = "11";
	
	qsalida <= 	not tq when (sel = "10" and (in1 = '1' and in2 = '1')) else tq;
	qsalidan <= not tq;
end Behavioral;