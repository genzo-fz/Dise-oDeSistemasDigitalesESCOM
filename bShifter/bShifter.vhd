library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bShifter is
    Port (	shift:	 	in bit_vector (0 to 3);
				q : 			out bit_vector (0 to 7));
end bShifter;

architecture arqBShifter of bShifter is
	constant a: bit_vector := "10000000";
begin
--------------------------------------------------------------------------subir contador
	process(shift)begin
			if(shift="0000" or shift="1000") then----shift a la izquierda
			q <= a;
		elsif(shift="0001")then
			q <= a rol 1;
		elsif(shift="0010")then
			q <= a rol 2;
		elsif(shift="0011")then
			q <= a rol 3;
		elsif(shift="0100")then
			q <= a rol 4;
		elsif(shift="0101")then
			q <= a rol 5;
		elsif(shift="0110")then
			q <= a rol 6;
		elsif(shift="0111")then
			q <= a rol 7;
		elsif(shift="1001")then----shift a la derecha
			q <= a ror 1;
		elsif(shift="1010")then
			q <= a ror 2;
		elsif(shift="1011")then
			q <= a ror 3;
		elsif(shift="1100")then
			q <= a ror 4;
		elsif(shift="1101")then
			q <= a ror 5;
		elsif(shift="1110")then
			q <= a ror 6;
		elsif(shift="1111")then
			q <= a ror 7;
		end if;
	end process;
end arqBShifter;