library ieee;
use ieee.std_logic_1164.all;

entity mealy is port
(
	x, clk, clr: in std_logic;
	display : out std_logic_vector(0 to 5)
);
attribute pin_numbers of mealy:entity is
"display(0):14, display(1):15, display(2):16, display(3):17, display(4):18, display(5):19";
end mealy;
	
architecture amealy of mealy is
	SIGNAL q0, q1, d0, d1, y: std_logic;
	begin
	process(clk, clr)
	begin
	if(clr = '1') then
		display <= "111110";
	elsif clk'event and clk='1' then
		d1 <= ((not(q1) and q0 and x) or ((not q0) and q1));
		d0 <= (((not q1) and (not q0) and x) or (q1 and (not q0) and (not x)));
		q0 <= d0;
		q1 <= d1;
		y <= (q0 and q1 and x);
	end if;
	case y is
		when '1'=> display <= "110111";
		when '0'=> display <= "001111";
		when others => display <= "111110";
	end case;
	end process;
end amealy;
