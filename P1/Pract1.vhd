library ieee;
use ieee.std_logic_1164.all;

entity ff is port(
	S, R ,J ,K, CLK, D, T: in std_logic;
	selector:  in std_logic_vector(0  to 2);
	display: out std_logic_vector(5 downto 0)
);
attribute pin_numbers of ff:entity is
"CLR:10";
end ff;

architecture aff of ff is
	SIGNAL qsr, qjk, qd, qt, mux_out: std_logic;
	begin				
	process(CLK, selector(0), selector)
	begin
		if selector(0) = '1' then 
			qjk	<= '0';
			qt	<= '0';
			qd	<= '0';
			qsr	<= '0';
	 	elsif CLK'event and CLK='1' then
			qjk <= ((not K) and qjk) or (J and(not qjk));
			qt  <= ((not T) and qt) or (T and (not qt));
			qd  <= D;
			qsr	<= ((not R) and qsr) or S;
		end if;
	case selector is
		when "000" => mux_out <= qjk;
		when "001" => mux_out <= qt;
		when "010" => mux_out <= qd;
		when "011" => mux_out <= qsr;
		when others => mux_out <= '0';
	end case;
	if(mux_out) = '1' then
		display <="011000";
	 else
	 	display <="111111";
	end if;
end process;
end aff;
