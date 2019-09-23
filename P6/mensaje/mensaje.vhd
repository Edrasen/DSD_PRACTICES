library ieee;
use ieee.std_logic_1164.all;

entity mensaje is port (
	e, clk, clr : in std_logic;
	display : out std_logic_vector (6 downto 0)
);
attribute pin_numbers of mensaje : entity is
	"clk:1 clr:2 e:3"
	& " display(0):15 display(1):16 display(2):17 display(3):18 display(4):19 display(5):20 display(6):21";
end mensaje;

architecture aMensaje of mensaje is
constant le: std_logic_vector(6 downto 0) := "0110000";
constant ld: std_logic_vector(6 downto 0) := "1000010";
constant lg: std_logic_vector(6 downto 0) := "0000100";
constant la: std_logic_vector(6 downto 0) := "0001000";
constant lr: std_logic_vector(6 downto 0) := "1111010";
constant ll: std_logic_vector(6 downto 0) := "1110001";
constant li: std_logic_vector(6 downto 0) := "1001111";
constant ln: std_logic_vector(6 downto 0) := "1101010";

constant m0: std_logic_vector(1 downto 0) := "00";
constant m1: std_logic_vector(1 downto 0) := "01";
constant m2: std_logic_vector(1 downto 0) := "10";

constant q0: std_logic_vector(8 downto 0) := m0 & le;
constant q1: std_logic_vector(8 downto 0) := m0 & ld;
constant q2: std_logic_vector(8 downto 0) := m0 & lg;
constant q3: std_logic_vector(8 downto 0) := m0 & la;
constant q4: std_logic_vector(8 downto 0) := m0 & lr;
constant q5: std_logic_vector(8 downto 0) := m1 & la;
constant q6: std_logic_vector(8 downto 0) := m0 & ll;
constant q7: std_logic_vector(8 downto 0) := m2 & la;
constant q8: std_logic_vector(8 downto 0) := m0 & li;
constant q9: std_logic_vector(8 downto 0) := m0 & ln;


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

end aMensaje;
