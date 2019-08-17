library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity mux is port(
	sig1: in std_logic_vector(0 to 2);
	sig2: in std_logic_vector(0 to 2);
	ref: in std_logic_vector(0 to 2);
	selector: in std_logic;
	display: out std_logic_vector(6 downto 0)
);

end mux;

ARCHITECTURE amux of mux is
	SIGNAL sal1 : std_logic_vector(0 to 2);
	SIGNAL comp :  std_logic_vector(0 to 2);
	
	begin
		sal1 <= sig1 when selector = '0' else sig2;
		
		comp <= "001" when ((unsigned(sal1)) > (unsigned(ref))) else
				"010" when (sal1 = ref) else
				"100" when ((unsigned(sal1)) < (unsigned(ref)));

		display <= 	"1111000" when comp = "001" else
					"1001000" when comp = "010" else
					"1001110" when comp = "100";
end amux;	  
