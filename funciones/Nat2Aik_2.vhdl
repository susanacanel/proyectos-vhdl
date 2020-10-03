-- 21.09.20 ---------------- Susana Canel ------------------ Nat2Aik_2.vhdl
-- CONVERSOR DE BCD NATURAL A CODIGO BCD AIKEN.
-- CON CONTROL DE LOS DATOS DE ENTRADA.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------
entity Nat2Aik_2 is
	port(n_i   :  in std_logic_vector(3 downto 0);
		   a_o   : out std_logic_vector(3 downto 0)
		  );
end entity Nat2Aik_2;

-------------------------------------------------------------------------
architecture WhenElse of Nat2Aik_2 is begin

	a_o <= n_i when unsigned(n_i) < 5 else 
	       std_logic_vector(unsigned(n_i) + 6) when unsigned(n_i) < 10 else
         "XXXX";
	                   					
end architecture WhenElse;
-------------------------------------------------------------------------
