-- 23.08.18 -------- Susana Canel -------- CompEntN.vhd      
-- COMPARADOR GENERICO DE DOS NUMEROS ENTEROS DE N BITS
-- CON SALIDAS A MAYOR B, A MENOR B, A IGUAL B 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------
entity CompEntN is
   generic(N  : positive := 4);
   port(a_i   :  in std_logic_vector(N-1 downto 0);
        b_i   :  in std_logic_vector(N-1 downto 0);
        may_o : out std_logic;
        men_o : out std_logic;
        igu_o : out std_logic);
end entity CompEntN;

-------------------------------------------------------
architecture Arq of CompEntN is begin

	may_o <= '1' when signed(a_i) > signed(b_i) else
	         '0';
	men_o <= '1' when signed(a_i) < signed(b_i) else
	         '0';   
	igu_o <= '1' when signed(a_i) = signed(b_i) else
	         '0';	         
end architecture Arq;
-------------------------------------------------------
