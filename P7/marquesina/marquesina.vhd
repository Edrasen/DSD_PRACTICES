library ieee;
use ieee.std_logic_1164.all;

entity marquesina is port(
	clk, clr : in std_logic;
	e : in std_logic_vector(2 downto 0);
	display : inout std_logic_vector(9 downto 0)
);
end marquesina;

architecture a_marq of marquesina is 

constant nd : std_logic_vector(2 downto 0) := "111";
constant d0 : std_logic_vector(2 downto 0) := "110";
constant d1 : std_logic_vector(2 downto 0) := "101";
constant d2 : std_logic_vector(2 downto 0) := "011";

constant nl : std_logic_vector(6 downto 0) := "1111111";
constant lH : std_logic_vector(6 downto 0) := "1001000";
constant lO : std_logic_vector(6 downto 0) := "0000001";
constant lL : std_logic_vector(6 downto 0) := "1110001";
constant lA : std_logic_vector(6 downto 0) := "0001000";

constant q0 : std_logic_vector(9 downto 0) := nd & nl;
constant q1 : std_logic_vector(9 downto 0) := d0 & lH;
constant q2 : std_logic_vector(9 downto 0) := d1 & lH;
constant q3 : std_logic_vector(9 downto 0) := d0 & lO;
constant q4 : std_logic_vector(9 downto 0) := d2 & lH;
constant q5 : std_logic_vector(9 downto 0) := d1 & lO;
constant q6 : std_logic_vector(9 downto 0) := d0 & lL;
constant q7 : std_logic_vector(9 downto 0) := d2 & lO;
constant q8 : std_logic_vector(9 downto 0) := d1 & lL;
constant q9 : std_logic_vector(9 downto 0) := d0 & lA;
constant q10 : std_logic_vector(9 downto 0) := d2 & lL;
constant q11 : std_logic_vector(9 downto 0) := d1 & lA;
constant q12 : std_logic_vector(9 downto 0) := d2 & lA;

begin 
process(clk, clr)
begin
	if(clr = '1') then 
		display <= q0;
	elsif (rising_edge(clk)) then
		case display is
			when q0 =>
				if (e = "000" or e = "001") then
					display <= q0;
				elsif (e = "010") then
					display <= q1;
				else
					display <= "----------";
				end if;
			when q1 =>
				if (e = "010") then
					display <= q1;
				elsif (e = "011") then
					display <= q2;
				else 
					display <= "----------";
				end if;
			when q2 =>
				if (e = "011") then 			
					display <= q3;
				elsif (e = "100") then
					display <= q4;
				else
					display <= "----------";
				end if;
		   	when q3 =>
				if(e = "011") then
					display <= q2;
				elsif (e = "100") then
					display <= q4;
				else 
					display <= "----------";
				end if;
			when q4 =>
				if(e = "100") then
					display <= q5;
				elsif (e = "101") then
					display <= q7;
				else 
					display <= "----------";
				end if;							
			when q5 =>
				if(e = "100") then
					display <= q6;
				elsif (e = "101") then
					display <= q7;
				else 
					display <= "----------";
				end if;
			when q6 =>
				if(e = "100") then
					display <= q4;
				elsif (e = "101") then
					display <= q7;
				else 
					display <= "----------";
				end if;
			when q7 =>
				if(e = "101") then
					display <= q8;
				elsif (e = "110") then
					display <= q10;
				else 
					display <= "----------";
				end if;
			when q8 =>
				if(e = "101") then
					display <= q9;
				elsif (e = "110") then
					display <= q10;
				else 
					display <= "----------";
				end if;
			when q9 =>
				if(e = "101") then
					display <= q7;
				elsif (e = "110") then
					display <= q10;
				else 
					display <= "----------";
				end if;
			when q10 =>
				if(e = "110") then
					display <= q11;
				elsif (e = "111") then
					display <= q12;
				else 
					display <= "----------";
				end if;
			when q11 =>
				if(e = "110") then
					display <= q10;
				elsif (e = "111") then
					display <= q12;
				else 
					display <= "----------";
				end if;
			when q12 =>
				if(e = "111") then
					display <= q12;
				elsif (e = "000") then
					display <= q0;
				else 
					display <= "----------";
				end if;
			when others =>
					display <= "----------";
			end case;
	end if;
end process;
end a_marq;
