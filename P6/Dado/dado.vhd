library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity dado is port (
	e, clk, clr : in std_logic;
	display : out std_logic_vector (6 downto 0)
);
attribute pin_numbers of dado : entity is
	"clk:1 clr:2 e:3"
	& " display(0):15 display(1):16 display(2):17 display(3):18 display(4):19 display(5):20 display(6):21";
end dado;

architecture a_dado of dado is 

constant q1: std_logic_vector(6 downto 0) := "1001111"; 
constant q2: std_logic_vector(6 downto 0) := "0010010"; 
constant q3: std_logic_vector(6 downto 0) := "0000110"; 
constant q4: std_logic_vector(6 downto 0) := "1001100"; 
constant q5: std_logic_vector(6 downto 0) := "0100100"; 
constant q6: std_logic_vector(6 downto 0) := "0100000"; 

signal estado : std_logic_vector(6 downto 0);

begin
	process(clk, clr)
	begin
		if clr = '1' then
			estado <= q1;
		elsif(clk'event and clk = '1') then 
			if e = '1' then
				case estado is
					when q1 =>
						estado <= q2;
					when q2 =>
						estado <= q3;
					when q3 =>
						estado <= q4;
					when q4 =>
						estado <= q5;
					when q5 =>
						estado <= q6;  
					when others =>
						estado <= q1;
				end case;
			else
			estado <=  estado;
			end if;	
		end if;
		display <= estado;
 	 end process; 
end a_dado; 
