-- 05.09.18 ----------- Susana Canel ---------- CompNORn.vhdl  
-- COMPUERTA NOR GENERICA DE N ENTRADAS
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
entity CompNORn is
	generic(N          : positive := 4);
 	port(   entrada_i  : in  std_logic_vector(N-1 downto 0);
		    salida_o   : out std_logic);
end entity CompNORn;

------------------------------------------------------------
architecture Algoritmica of CompNORn is begin

NORgenerica:
	process (entrada_i)
		variable aux : std_logic;
    begin
		aux := '1';
		
		for i in N-1 downto 0 loop
            if entrada_i(i)='1' then
	           aux := '0';
	        end if;
        end loop;
		
		salida_o <= aux;
		
    end process NORgenerica;
	
end architecture Algoritmica;
------------------------------------------------------------


