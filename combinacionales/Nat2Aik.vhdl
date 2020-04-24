-- 22.08.18 ----- Susana Canel ----- Nat2Aik.vhdl
-- CONVERSOR DE BCD NATURAL A CODIGO BCD AIKEN

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------
entity Nat2Aik is
   port(n_i   : in  std_logic_vector(3 downto 0);
        a_o   : out std_logic_vector(3 downto 0)
        );
end entity Nat2Aik;

-------------------------------------------------
architecture WhenElse of Nat2Aik is begin

    a_o <= n_i when unsigned(n_i) < 5  else 
	   std_logic_vector(unsigned(n_i) + 6);
	                   					
end architecture WhenElse;
-------------------------------------------------