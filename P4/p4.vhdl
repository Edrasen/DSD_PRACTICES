library ieee;
use ieee.std_logic_1164.all;

entity multdis is port(
	clk, clr :in std_logic;
	display	 :out std_logic_vector(0 to 6);
	q		 :out std_logic_vector(0 to 2)
	);
end multdis;

architecture amultdis of multdis is
	begin
	process(clk, clr)
	begin
		if (clr = '1') then
			q <= "000";			
		elsif clk'event and clk = '1' then
			q(0) <= q(1) and (q(2) xor q(0));
			q(1) <= q(2) and (q(1) xor q(0));
			q(2) <= q(0) and (q(1) xor q(2));
		end if;
		case(q) is
			when "011" => display <= "1001111";
			when "101" => display <= "0011000";
 		    when "110" => display <= "1101010";
			when others => display <= "1001111";
		end case;
	end process;
end amultdis;
