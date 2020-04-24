-- 30.08.18 ------- Susana Canel ------ ParidadN.vhdl
-- ARBOL DE PARIDAD GENERICO, DE N BITS,  
-- CON SALIDAS: PARIDAD PAR E IMPAR.

library ieee;     
use ieee.std_logic_1164.all;
----------------------------------------------------
entity ParidadN is
   generic(N    : positive :=6);
   port(   a_i  :  in std_logic_vector(N-1 downto 0);
           pp_o : out std_logic;
           pi_o : out std_logic   );
end entity ParidadN;
----------------------------------------------------
architecture Arq of ParidadN is begin
Arbol:
	process (a_i) is
		variable aux : std_logic;
    begin
		aux := a_i(0);
		for i in 1 to N-1 loop
			aux := aux xor a_i(i);
		end loop;
		
		pp_o <= not aux;
		pi_o <= aux;
    end process Arbol;

end architecture Arq;
----------------------------------------------------

