library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fut is
	port(	
			w1,w2: 					in std_logic;
			clk : 					in  STD_LOGIC;
			clk_div:				 	inout STD_LOGIC := '0';
			clk_d:				 	inout STD_LOGIC := '0';
			dis:			   		out STD_LOGIC_VECTOR (0 to 7);
			act: 						inout std_logic_vector(0 to 1)
		);
end fut;

architecture Behavioral of fut is
	constant d0: std_logic_vector := "00000011";
	constant d1: std_logic_vector := "10011111";
	constant d2: std_logic_vector := "00100101";
	constant d3: std_logic_vector := "00001101";
	constant d4: std_logic_vector := "10011001";
	constant d5: std_logic_vector := "01001001";
	constant d6: std_logic_vector := "01000001";
	constant d7: std_logic_vector := "00011111";
	constant d8: std_logic_vector := "00000001";
	constant d9: std_logic_vector := "00001001";
	
	signal dis1, dis2: std_logic_vector(0 to 7);
	signal sc1, sc2: 	integer range 0 to 10 := 0;
	signal b: integer range 0 to 2 := 0;
	
	constant contador_max: integer := 500000;
	signal contador: integer range 0 to contador_max;
	
	constant cmax: integer := 80000;
	signal cont: integer range 0 to cmax;
begin
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
	
	clk_dis: process(clk) begin
		if(rising_edge(clk))then
			if(cont<cmax) then
				cont<=cont+1;
			else
				cont<=0;
				clk_d<=not clk_d;
			end if;
		end if;
	end process clk_dis;
	
	process(clk_div, w1, w2)begin
		if rising_edge(clk_div) then
			if w1='1' then
				b<=1;
			elsif w2='1' and sc1>0 then
				b<=2;
			elsif sc1=10 or sc2=10 then 
				sc1<=0; sc2<=0;
			end if;
			------------------------------
			if b=1 and w1='0' then
				sc1<=sc1+1;
				b<=0;
			elsif b=2 and w2='0' then
				sc1<=sc1-1;
				b<=0;
			end if;
		end if;
	end process;
	 
	mux: process(clk_d) begin
		if(clk_d='0') then
			act<="10";
			if(sc1=0) then
				dis1 <= d0;
			elsif(sc1=1) then
				dis1 <= d1;
			elsif(sc1=2) then
				dis1 <= d2;
			elsif(sc1=3) then
				dis1 <= d3;
			elsif(sc1=4) then
				dis1 <= d4;
			elsif(sc1=5) then
				dis1 <= d5;
			elsif(sc1=6) then
				dis1 <= d6;
			elsif(sc1=7) then
				dis1 <= d7;
			elsif(sc1=8) then
				dis1 <= d8;
			else
				dis1 <= d9;
			end if;
		else
			act<="01";
			if(sc1=0) then
				dis2 <= d0;
			elsif(sc1=1) then
				dis2 <= d1;
			elsif(sc1=2) then
				dis2 <= d2;
			elsif(sc1=3) then
				dis2 <= d3;
			elsif(sc1=4) then
				dis2 <= d4;
			elsif(sc1=5) then
				dis2 <= d5;
			elsif(sc1=6) then
				dis2 <= d6;
			elsif(sc1=7) then
				dis2 <= d7;
			elsif(sc1=8) then
				dis2 <= d8;
			else
				dis2 <= d9;
			end if;
		end if;
	end process mux;
		dis <=dis1 when act = "10" else
				dis2;
end Behavioral;

