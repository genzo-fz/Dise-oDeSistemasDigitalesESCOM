library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MATRIZ_PRUEBA is

PORT( 	CLKD : 		IN STD_LOGIC;		
		COLUMNA : 	OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);

end MATRIZ_PRUEBA;

architecture Behavioral of MATRIZ_PRUEBA is
SIGNAL EDO : INTEGER RANGE 0 TO 7 := 0;
signal band: integer range 0 to 1;
begin
	
	MAT: PROCESS(CLKD)BEGIN
		IF RISING_EDGE(CLKD)THEN
			IF(EDO=0)THEN
					COLUMNA<="11011111";
			ELSIF(EDO=1)THEN
					COLUMNA<="01111111";
			ELSIF(EDO=2)THEN
				if(band<1)then
						else
						end if;
				COLUMNA<="11101111";
			ELSIF(EDO=3)THEN
				if(band<1)then
						else
						end if;
				COLUMNA<="10111111";
			ELSIF(EDO=4)THEN
				if(band<1)then
						else
						end if;
				COLUMNA<="11110111";
			ELSIF(EDO=5)THEN
				if(band<1)then
						else
						end if;
				COLUMNA<="11111110";
			ELSIF(EDO=6)THEN
				if(band<1)then
						else
						end if;
				COLUMNA<="11111011";
			ELSif(EDO=7)THEN
				if(band<1)then
						else
						end if;
				COLUMNA<="11111101";
				EDO<=0;
			END IF;
			EDO<=EDO+1;
			band<=band+1;
		END IF;
	END PROCESS MAT;
end Behavioral;

