library ieee;
use ieee.std_logic_1164.all;

entity boleta is port (
	e, clk, clr : in std_logic;
	display : out std_logic_vector (6 downto 0)
);
attribute pin_numbers of boleta : entity is
	"clk:1 clr:2 e:3"
	& " display(0):15 display(1):16 display(2):17 display(3):18 display(4):19 display(5):20 display(6):21";
end boleta;

architecture aboleta of boleta is
constant n2: std_logic_vector(6 downto 0) := "0010010";
constant n0: std_logic_vector(6 downto 0) := "0000001";
constant n1: std_logic_vector(6 downto 0) := "1001111";
constant n3: std_logic_vector(6 downto 0) := "0000110";
constant n9: std_logic_vector(6 downto 0) := "0001100";
constant n4: std_logic_vector(6 downto 0) := "1001100";


constant m0: std_logic_vector(1 downto 0) := "00";
constant m1: std_logic_vector(1 downto 0) := "01";
constant m2: std_logic_vector(1 downto 0) := "10";

constant q0: std_logic_vector(8 downto 0) := m0 & n2;
constant q1: std_logic_vector(8 downto 0) := m0 & n0;
constant q2: std_logic_vector(8 downto 0) := m0 & n1;
constant q3: std_logic_vector(8 downto 0) := m0 & n3;
constant q4: std_logic_vector(8 downto 0) := m1 & n0;
constant q5: std_logic_vector(8 downto 0) := m0 & n9;
constant q6: std_logic_vector(8 downto 0) := m2 & n0;
constant q7: std_logic_vector(8 downto 0) := m1 & n2;
constant q8: std_logic_vector(8 downto 0) := m0 & n4;
constant q9: std_logic_vector(8 downto 0) := m1 & n3;


signal  estado: std_logic_vector(8 downto 0);

begin

	process(clk, clr)
	begin
		if (clr = '1') then
			estado <= q0;
		elsif(clk'event and clk = '1') then
			if (e = '1') then
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
					when others =>
						estado <= q0;
				end case;
				else
					estado <= estado;
				end if;
		end if;
	end process;

	display <= estado(6 downto 0);

end aboleta;
