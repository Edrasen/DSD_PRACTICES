LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Registro is port(
	Dato: in std_logic_Vector(5 downto 0);
	Clk, Clr: in std_logic;
	ini: in std_logic;
	a: out std_logic_vector(5 downto 0);
	lb, eb, ec: out std_logic
	);
	ATTRIBUTE pin_numbers of Registro: entity is
	"Clk:1 Clr:2 ini:3 "
	&"Dato(0):6 Dato(1):7 Dato(2):8 Dato(3):9 Dato(4):10 Dato(5):11 "
	&"a(0):15 a(1):16 a(2):17 a(3):18 a(4):19 a(5):20 "
	&"lb:21 eb:22 ec:23";
END Registro;

ARCHITECTURE a_Registro of Registro is
	signal z,la,ea: std_logic;
	Type estados is (e0, e1, e2);
	signal act, sig: estados;

	BEGIN
	REGISTROA: PROCESS(Clk,Clr)
		BEGIN
		IF(Clr = '1') Then
		 	a <= (others => '0');
		ELSIF(rising_edge(Clk)) Then
		 	if(ea = '0' and la = '1')Then
				a <= dato; --Carga
			elsif(ea = '1' and la = '0') Then
				a(4 downto 0) <= a(5 downto 1); --Corrimiento a la derecha
				a(5) <= '0';
			elsif(ea = '0' and la = '0') Then 
				a <= a;--Retencion
			end if;
		END IF;
 	END PROCESS REGISTROA;
	
	z <= a(0) OR a(1) OR a(2) OR a(3) OR a(4) OR a(5);

	FSM:PROCESS(z, act, a(0), ini)
		BEGIN
		la <= '0';
		lb <= '0';
		ea <= '0';
		eb <= '0';
		ec <= '0';
		CASE act is
			when e0 => 
				lb <= '1';
				if(Ini = '1') Then
					sig <= e1;
				else
					la <= '1';
					sig <= e0;
				end if;

			when e1 =>
				ea <= '1';
				IF(z = '1') Then
					if(a(0) = '1') Then
						eb <= '1';
						sig <= e1;
					else
						sig <= e1;
					end if;
				ELSE
					sig <= e2;
				END IF;

			when e2 =>
				ec <= '1';
				if(ini = '1') Then
					sig <= e2;
				else
					sig <= e0;
				end if;			
		END CASE;
	END PROCESS FSM;

	Uc:Process(Clk,Clr)
	BEGIN
		If(Clr = '1') Then
			act <= e0;
		ELSIF(rising_edge(Clk)) Then
			act <= sig;
		end if;
	END PROCESS Uc;

END ARCHITECTURE;
