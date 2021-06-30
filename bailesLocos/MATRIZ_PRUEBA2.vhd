library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MATRIZ_PRUEBA is

PORT( 	CLKD : 		IN STD_LOGIC;
		FILA : 		OUT STD_LOGIC_VECTOR(7 DOWNTO 0)	
	);

end MATRIZ_PRUEBA;

architecture Behavioral of MATRIZ_PRUEBA is
SIGNAL EDO : INTEGER RANGE 0 TO 7 := 0;
signal band: integer range 0 to 1;
begin
	
	MAT: PROCESS(CLKD)BEGIN
		IF RISING_EDGE(CLKD)THEN
			IF(EDO=0)THEN
				FILA<="00011100";
			ELSIF(EDO=1)THEN
				FILA<="00001000";
			ELSIF(EDO=2)THEN
				if(band<1)then
					FILA<="01011100";
				else
					FILA<="00011101";
				end if;
			ELSIF(EDO=3)THEN
				if(band<1)then
					FILA<="00101010";
				else
					FILA<="00101010";
				end if;
			ELSIF(EDO=4)THEN
				if(band<1)then
					FILA<="00011101";
				else
					FILA<="01011100";
				end if;
			ELSIF(EDO=5)THEN
				if(band<1)then
					FILA<="00100010";
				else
					FILA<="00100100";
				end if;
			ELSIF(EDO=6)THEN
				if(band<1)then
					FILA<="01000001";
				else
					FILA<="01000010";
				end if;
			ELSif(EDO=7)THEN
				if(band<1)then
					FILA<="10000010";
				else
					FILA<="00100001";
				end if;
				EDO<=0;
			END IF;
			EDO<=EDO+1;
			band<=band+1;
		END IF;
	END PROCESS MAT;
end Behavioral;

