library ieee;
use ieee.std_logic_1164.all;

entity hexadec is port (
	e, clk, clr : in std_logic;
	display : out std_logic_vector (6 downto 0)
);
attribute pin_numbers of hexadec : entity is
	"clk:1 clr:2 e:3"
	& " display(0):15 display(1):16 display(2):17 display(3):18 display(4):19 display(5):20 display(6):21";
end hexadec;

architecture a_hexadec of hexadec is 

constant q0: std_logic_vector(6 downto 0) := "0000001";
constant q1: std_logic_vector(6 downto 0) := "1001111"; 
constant q2: std_logic_vector(6 downto 0) := "0010010"; 
constant q3: std_logic_vector(6 downto 0) := "0000110"; 
constant q4: std_logic_vector(6 downto 0) := "1001100"; 
constant q5: std_logic_vector(6 downto 0) := "0100100"; 
constant q6: std_logic_vector(6 downto 0) := "0100000"; 
constant q7: std_logic_vector(6 downto 0) := "0001111"; 
constant q8: std_logic_vector(6 downto 0) := "0000000"; 
constant q9: std_logic_vector(6 downto 0) := "0001100"; 
constant qa: std_logic_vector(6 downto 0) := "0001000"; 
constant qb: std_logic_vector(6 downto 0) := "1100000"; 
constant qc: std_logic_vector(6 downto 0) := "0110001"; 
constant qd: std_logic_vector(6 downto 0) := "1000010"; 
constant qe: std_logic_vector(6 downto 0) := "0110000"; 
constant qf: std_logic_vector(6 downto 0) := "0111000"; 
 
signal estado : std_logic_vector(6 downto 0);

begin
	process(clk, clr)
	begin
		if clr = '1' then
			estado <= q0;
		elsif(clk'event and clk = '1') then 
			if e = '1' then
				case estado is
					when q0 =>
						estado <= q1;
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
					when q6 =>
						estado <= q7;
					when q7 =>
						estado <= q8;
					when q8 =>
						estado <= q9; 
					when q9 =>
						estado <= qa;
					when qa =>
						estado <= qb;
					when qb =>	
	  		  	    		estado <= qc;
					when qc =>
						estado <= qd;
					when qd =>
						estado <= qe;
					when qe =>
						estado <= qf;
					when others =>
						estado <= q0;
				end case;
			else
			estado <=  estado;
			end if;	
		end if;
 	 end process;
	 display <= estado;
end a_hexadec;
