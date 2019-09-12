	library ieee;
use ieee.std_logic_1164.all;

entity Practica4 is port (
	clk, clr : IN std_logic;
	display : OUT std_logic_vector(0 TO 6);
	Q2, Q1,Q0 : OUT std_logic
);
ATTRIBUTE PIN_NUMBERS OF Practica4 : ENTITY IS
	"clk:1 clr:2"
	&" display(0):19 display(1):18 display(2):20"
	&" display(3):17 display(4):22 display(5):21 display(6):16 Q2:14 Q1:23 Q0:15";
end entity;

architecture aPractica4 of Practica4 is
begin

    process(CLK,CLR, q2, q1, q0)
		begin
		if (CLR = '1') then
			Q2 <= '0';
			Q1 <= '1';
			Q0 <= '1';
		elsif (CLK'event AND CLK = '1') then
			Q2 <= Q0 AND ( Q2 XOR Q1 );
			Q1 <= Q2 AND ( Q1 XOR Q0 );
			Q0 <= Q1 AND ( Q2 XOR Q0 );
		end if;		
		display(0) <= Q1 AND (Q2 XOR Q0); 
		display(1) <= Q2 AND (NOT Q0) AND Q1;
		display(2) <= Q2 AND (NOT Q1) AND Q0;
		display(3) <= '1';
		display(4) <= (NOT Q2) AND Q1 AND Q0;
		display(5) <= display(0);
		display(6) <= display(4); -- G
	end process;
end architecture;
