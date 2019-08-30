LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mealy is port(
	CLK, CLR, X	:in std_logic;
	display		:out std_logic_vector(6 downto 0)
 	);
attribute pin_numbers of mealy:entity is
"CLK:1, CLR:2, X:3";
end mealy;

ARCHITECTURE amealy of mealy is
	signal D0, D1, Q0, Q1, Y: std_logic;
BEGIN
	PROCESS(CLK, CLR)
	BEGIN
	if(CLR = '1') then
		Q0 <= '0';
		Q1 <= '0';
	elsif(CLK' EVENT AND CLK = '1') then
		Q1 <= ((NOT Q1) AND Q0 AND X) OR ((NOT Q0) AND Q1);
		Q0 <= ((NOT Q1) AND (NOT Q0) AND X) OR (Q1 AND (NOT Q0) AND (NOT X));
		end if;
	Y <= Q0 AND Q1 AND X;
	CASE (Y) is
		when '1' => display <= "1110111";
		when others => display <= "1001111";
	END CASE;
	END PROCESS;
END amealy;