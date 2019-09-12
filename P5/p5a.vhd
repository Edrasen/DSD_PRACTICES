library ieee; 
use ieee.std_logic_1164.all;

entity contador is port(
	clk, clr, en: in std_logic;
	q: inout std_logic_vector(2 downto 0)
);
attribute pin_numbers of contador : entity is
	"clk:1 clr:2"
	& " q(0):14 q(1):15 q(2):16";
end entity;

architecture a_contador of contador is
begin

process(clk, clr)
variable acc : std_logic;
begin
		if(clr = '1') then
			q <= "000";
		elsif(rising_edge(clk)) then
			if (en = '0') then
				q <= q;
			else
				for i in 0 to 2 loop
					acc := '1';
					for j in 0 to i-1 loop
						acc := acc and q(j);
					end loop;
					q(i) <= q(i) xor (en and acc);
				end loop;
			end if;
	   	end if;
 end process;
 end architecture;
