library ieee;
use ieee.std_logic_1164.all;

entity registro is port(
	clk, clr : in std_logic;
	d : in std_logic_vector(0 to 6);
	selector : in std_logic_vector(0 to 1);
	es : in std_logic;
	q : out std_logic_vector(0 to 6)
);
end registro;

architecture aregistro of registro is 
	begin
	process(clk, clr)
	begin
		if(clr = '1') then
			q <= "0000000";
		elsif(clk'event and clk = '1') then
			if (selector = "00") then
				for i in 0 to 6 loop	--carga
					q(i) <= d(i);
				end loop;
			elsif (selector = "01") then
				for i in 0 to 6 loop	--retencion
					q(i) <= q(i);
				end loop;
			elsif (selector = "10") then
				for i in 0 to 6 loop 	--corrimiento a la derecha
					if(i > 0) then
						q(i) <= q(i-1);
					else
						q(i) <= es;
					end if;
				end loop;
			else 
				for i in 0 to 6 loop	--corrimiento a la izquierda
					if(i < 6) then 
						q(i) <= q(i+1);
					else
						q(i) <= es;					
					end if;
				end loop;
			end if;
		end if;
	end process;
end aregistro;
