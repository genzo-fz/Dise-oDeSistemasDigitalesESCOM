library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pPong is
	Port ( 
				w1,w2: 					in std_logic;
				clk : 					in  STD_LOGIC;
				clk_div:				 	inout STD_LOGIC := '0';
				clk_d:				 	inout STD_LOGIC := '0';
				dis:			   		out STD_LOGIC_VECTOR (0 to 7);
				q : 						out  BIT_VECTOR (0 to 7);
				act: 						inout std_logic_vector(0 to 1)
			);
end pPong;

architecture Behavioral of pPong is
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
	
	constant m1: bit_vector := "11111110";
	
	constant contador_max: integer := 500000;
	signal contador: integer range 0 to contador_max;
	
	constant cmax: integer := 100000;
	signal cont: integer range 0 to cmax;
	
	signal dis1, dis2: std_logic_vector(0 to 7);
	signal sc1, sc2: 	integer range 0 to 10 := 0;
	signal limite: 	integer range 0 to 9  := 4;
	signal band: 		integer range 0 to 3  := 2;
	
	signal Sreg : bit_vector(0 to 7);	
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
	
	mov: process(clk_div, w1, w2) begin
		if(rising_edge(clk_div))then	
			if(w1 = '0' and (limite=0 or limite=2 or limite=1)) then------------p1
				band <= 0;
			end if;
			if(w2 = '0' and (limite=9 or limite=7 or limite=8)) then------------p2
				band <= 1;
			end if;
			
			----------rotacion a la derecha
			if(band = 0) then
				limite <= limite +1;
			elsif(band = 1) then-------rotacion a la izquierda
				limite <= limite -1;
			elsif(band = 2) then 
				limite<=2;
			elsif(band = 3) then 
				limite<=7;
			end if;
			
			--------movimiento
			if(limite = 0) then
				sc1<=sc1+1;
				band <= 2;
			elsif(limite = 1) then
				Sreg<= m1 ror limite;
			elsif(limite = 2) then
				Sreg<= m1 ror limite;
			elsif(limite = 3) then
				Sreg<= m1 ror limite;
			elsif(limite = 4) then
				Sreg<= m1 ror limite;
			elsif(limite = 5) then
				Sreg<= m1 ror limite;
			elsif(limite = 6) then
				Sreg<= m1 ror limite;
			elsif(limite = 7) then
				Sreg<= m1 ror limite;
			elsif(limite = 8) then
				Sreg<= m1;
			elsif(limite = 9) then
				sc2<=sc2+1;
				band <= 3;
			end if;
			if(sc2=10 or sc1=10) then
				Sreg<= "01010101";
				Sreg<= "10101010";
				band <= 2;
				sc1<=0; sc2<=0;
			end if;
		end if;
	end process mov;
	
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
			if(sc2=0) then
				dis2 <= d0;
			elsif(sc2=1) then
				dis2 <= d1;
			elsif(sc2=2) then
				dis2 <= d2;
			elsif(sc2=3) then
				dis2 <= d3;
			elsif(sc2=4) then
				dis2 <= d4;
			elsif(sc2=5) then
				dis2 <= d5;
			elsif(sc2=6) then
				dis2 <= d6;
			elsif(sc2=7) then
				dis2 <= d7;
			elsif(sc2=8) then
				dis2 <= d8;
			else
				dis2 <= d9;
			end if;
		end if;
	end process mux;
	
		dis <=dis1 when act = "10" else
				dis2;
		q<=not Sreg;
end Behavioral;

