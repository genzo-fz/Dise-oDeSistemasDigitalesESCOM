library ieee;
use ieee.std_logic_1164.all;

entity FFD is
port(
	d, t, clk, clr, J, K, S, R :in std_logic;
	SEL : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	DISPLAY : out std_logic_VECTOR(6 DOWNTO 0);
	qsalida, qsalidan : out std_logic
	);
end FFD;

ARCHITECTURE PROGRAMA OF FFD IS
SIGNAL QD, QT, QJK, QSR, Q : STD_LOGIC;
BEGIN
	PFFD : PROCESS ( CLK, CLR )
	BEGIN
		IF ( CLR = '1' ) THEN
			QD <= '0';
		ELSIF ( CLK'EVENT AND CLK = '1' )THEN
			QD <= D;
		END IF;
	END PROCESS PFFD;
	
	PFFT: PROCESS ( CLK, CLR )
	BEGIN
		IF (CLR = '1' ) THEN
			QT <= '0';
		ELSIF ( CLK'EVENT AND CLK = '1' )THEN
			QT <= T XOR QT;
		END IF;
	END PROCESS;
	
	PFFJK : PROCESS ( CLK, CLR )
	BEGIN
		IF ( CLR = '1' ) THEN
			QJK <= '0';
		ELSIF ( CLK'EVENT AND CLK = '1' ) THEN
			QJK <= (NOT K AND QJK) OR (J AND NOT QJK);
		END IF;
	END PROCESS PFFJK;

	PFFSR : PROCESS ( CLK, CLR )
	BEGIN
		IF (CLR = '1' ) THEN
			QSR <= '0';
		ELSIF ( CLK'EVENT AND CLK = '1' ) THEN
			IF (R = '1') THEN
				QSR <= '0';
			ELSIF ( S = '1') THEN
				QSR <= '1';
			ELSIF ( S = '0') THEN
				QSR <= '0';
			END IF;
		END IF;
	END PROCESS PFFSR;		

	WITH SEL SELECT Q <= 
			QD WHEN "00"
			QT WHEN "01"
			QSR WHEN "10"
			QJK WHEN "11";
	
	qsalida <= Q;
	qsalidan <= NOT Q;

	DISPLAY <= "0000001" WHEN ( Q = '0' ) ELSE
			"1001111";
END PROGRAMA;