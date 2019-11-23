LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY TecladoMatricial is port(
	Clk, Clr: 	in std_logic;
	Fila:		in std_logic_Vector(3 downto 0);
	Columna:	inout std_logic_Vector(2 downto 0);
	Display:	out std_logic_Vector(6 downto 0)
	);
	ATTRIBUTE pin_numbers of TecladoMatricial: entity is
		"Clk:1 Clr:2 Fila(0):8 Fila(1):9 Fila(2):10 Fila(3):11 "
		&"Display(0):15 Display(1):16 Display(2):17 Display(3):18 Display(4):19 Display(5):20 Display(6):21 "
		&"Columna(0):14 Columna(1):22 Columna(2):23";
END TecladoMatricial;

ARCHITECTURE a_TecladoMatricial of TecladoMatricial is
	Signal Op:	 std_logic;
	Signal Aux: std_logic_Vector(6 downto 0);
	BEGIN

	ContadorAnillo: PROCESS(Clk,Clr)
		BEGIN
		IF(Clr = '1')Then
			Columna <= "110";
		ELSIF(Clk'event and Clk = '1')Then
			Columna <= TO_STDLOGICVECTOR(TO_BITVECTOR(Columna) ROL 1);
		END IF;
	END PROCESS ContadorAnillo;


	Codificador: PROCESS(Columna,Fila)
		BEGIN
		Op <= NOT (Fila(3) AND Fila(2) AND Fila(1) AND Fila(0));
		CASE (Columna) is
			When "011" =>
		------------------------------------------
				CASE (Fila) is
				When "1110" =>
					Aux <= "1001111";--1
				When "1101" =>
					Aux <= "1001100";--4
				When "1011" =>
					Aux <= "0001111";--7
				When "0111" =>
					Aux <= "1100010";--*
				When others =>
					Aux <= "1111111";
				END CASE;

			When "101" =>
		------------------------------------------
				CASE (Fila) is
				When "1110" =>
					Aux <= "0010010";--2
				When "1101" =>
					Aux <= "0100100";--5
				When "1011" =>
					Aux <= "0000000";--8
				When "0111" =>
					Aux <= "0000001";--0
				When others =>
					Aux <= "1111111";
				END CASE;

			When "110" =>
		------------------------------------------
				CASE (Fila) is
				When "1110" =>
					Aux <= "0000110";--3
				When "1101" =>
					Aux <= "0100000";--6
				When "1011" =>
					Aux <= "0001100";--9
				When "0111" =>
					Aux <= "1001000";--gato
				When others =>
					Aux <= "1111111";
				END CASE;

			When others =>
		------------------------------------------
					Aux <= "1111111";
		END CASE;
	END PROCESS Codificador;


	Registro: PROCESS(Clk, Clr)
		BEGIN
		IF(Clr = '1')Then
			Op <= '0';
			Display <= "1111111";
		ELSIF(Clk'event and clk = '1')Then
			IF(Op = '1')Then--CARGA
				Display <= Aux;
			Elsif(Op = '0')Then--RETENCION
				Display <= Display;
			ELSE
				Display <= "1111111";
			END IF;
		END IF;
	END PROCESS Registro;

END a_TecladoMatricial;
