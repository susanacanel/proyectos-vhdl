-- 08.09.20 --------- Susana Canel -------- ProdEntN.vhd
-- MULTIPLICADOR GENERICO DE DOS NUMEROS ENTEROS, N BITS

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------
entity ProdEntN is
    generic(N    : positive  := 3);
	  port(   a_i  : in  std_logic_vector(  N-1 downto 0);
	          b_i  : in  std_logic_vector(  N-1 downto 0);
	          p_o  : out std_logic_vector(2*N-1 downto 0)  
	      );
end entity ProdEntN;

-------------------------------------------------------
architecture Arq of ProdEntN is begin

	p_o <= std_logic_vector(signed(a_i) * signed(b_i));
	                   					
end architecture Arq;
-------------------------------------------------------
