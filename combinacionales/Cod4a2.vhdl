-- 22.08.18 --------- Susana Canel -------- Cod4a2.vhd
-- CODIFICADOR DE PRIORIDAD, DE 4 ENTRADAS A 2 SALIDAS
-- CON SEÑAL DE GRUPO. 

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------
entity Cod4a2 is
	port(i_i   :  in std_logic_vector(3 downto 0);
             y_o   : out std_logic_vector(1 downto 0);
             g_o   : out std_logic
             );          
end entity Cod4a2;

------------------------------------------------------
-- LA ENTRADA 3 ES LA DE MAYOR PRIORIDAD. 
-- G=1 HAY AL MENOS UNA ENTRADA ACTIVA.

architecture WhenElse of Cod4a2 is begin

	y_o <= "11" when i_i(3)='1' else
	       "10" when i_i(2)='1' else
	       "01" when i_i(1)='1' else
	       "00";
	 
	g_o <= i_i(3) or i_i(2) or i_i(1) or i_i(0);
	         
end architecture WhenElse;
------------------------------------------------------
