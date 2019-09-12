library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contadorb is port(
	clk, clr, en, ud, l : in std_logic;
	d					: in std_logic_vector(6 downto 0);
	y 					: out std_logic;
	q					: inout std_logic_vector(6 downto 0)
);
attribute pin_numbers of contadorb : entity is
	"clk:1 clr:2"
	& " d(0):6 d(1):7 d(2):8 d(3):9 d(4):10 d(5):11 d(6):13"
	& " q(0):14 q(1):15 q(2):16 q(3):17 q(4):18 q(5):19 q(6):20 y:21";
end entity;

architecture a_contadorb of contadorb is
begin

process(clk, clr)
begin
	if(clr = '1') then 
		q <= (others =>'0');
	elsif (rising_edge(clk)) then 
		if(en = '0') then 
			q <= q;
		else
			if(l = '1') then 
				q <= d;
			else
				if(ud = '1') then 
					q <= q + 1;
			   	else
					q <= q - 1;
				end if;
		    end if;
		end if;
	end if;
y <= q(0) and q(1) and q(2) and q(3) and q(4) and q(5) and q(6);
end process;
end architecture;


