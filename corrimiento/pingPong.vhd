library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pingPong is
    Port ( 
				w1: 				in STD_LOGIC;
				w2: 				in STD_LOGIC;
				clk : 			in  STD_LOGIC;
				clk_div: 		inout STD_LOGIC := '0';
				sel : 			in  STD_LOGIC_VECTOR (2 downto 0);
				
				q : 				out  STD_LOGIC_VECTOR (0 to 7));
				
end pingPong;

architecture Behavioral of pingPong is
	-------------------------------
	constant contador_max: integer := 300000;
	signal contador: integer range 0 TO contador_max;
	signal limite: integer := 0;
	-------------------------------
	signal Sreg :  STD_LOGIC_VECTOR(0 TO 7);
	-------------------------------
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
	
	inicio: process(clk_div, w2, w1)			
	begin
			if(rising_edge(clk_div))then	
				if(w2 = '0') then ---------------paralelo izq o der(cuando el sel = 000/001)
					Sreg <= 	"11111111";
				elsif(sel = "000") then-------------desplazamiendo a la derecha
					Sreg(0)<= not w1;
					Sreg(1)<= Sreg(0);
					Sreg(2)<= Sreg(1);
					Sreg(3)<= Sreg(2);
					Sreg(4)<= Sreg(3);
					Sreg(5)<= Sreg(4);
					Sreg(6)<= Sreg(5);
					Sreg(7)<= Sreg(6);
				elsif(sel = "001") then----------desplazamiendo a la izquierda
					Sreg(7)<= not w1;
					Sreg(6)<= Sreg(7);
					Sreg(5)<= Sreg(6);
					Sreg(4)<= Sreg(5);
					Sreg(3)<= Sreg(4);
					Sreg(2)<= Sreg(3);
					Sreg(1)<= Sreg(2);
					Sreg(0)<= Sreg(1);
				elsif(sel = "100") then--------------------------------------paralelo
					Sreg(0)<= not w1;
					Sreg(1)<= w1;
					Sreg(2)<= w1;
					Sreg(3)<= w1;
					Sreg(4)<= w1;
					Sreg(5)<= w1;
					Sreg(6)<= w1;
					Sreg(7)<= w1;
				elsif(sel = "110") then--------------------------------------serie paralelo
					if(w1 = '0') then
						Sreg(0)<= not w1;
						Sreg(1)<= Sreg(0);
						Sreg(2)<= Sreg(1);
						Sreg(3)<= Sreg(2);
						Sreg(4)<= Sreg(3);
						Sreg(5)<= Sreg(4);
						Sreg(6)<= Sreg(5);
						Sreg(7)<= Sreg(6);
					else
						Sreg <= "00000000";
					end if;
					
				else
					if(sel = "010") then----------rotacion a la derecha
						limite <= limite +1;
						if(limite = 7) then
							limite <= 0;
						end if;
					elsif(sel = "011") then-------rotacion a la izquierda
						limite <= limite -1;
						if(limite = 0) then
							limite <= 7;
						end if;
					end if;
					if(limite = 0) then
						Sreg<= "11100000";
					elsif(limite = 1) then
						Sreg<= "01110000";
					elsif(limite = 2) then
						Sreg<= "00111000";
					elsif(limite = 3) then
						Sreg<= "00011100";
					elsif(limite = 4) then
						Sreg<= "00001110";
					elsif(limite = 5) then
						Sreg<= "00000111";
					elsif(limite = 6) then
						Sreg<= "10000011";
					elsif(limite = 7) then
						Sreg<= "11000001";
					end if;
				end if;
			end if;
	end process inicio;
	q <= Sreg;
end Behavioral;


