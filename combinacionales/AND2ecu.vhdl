-- 15.08.18 ------ Susana Canel ------- AND2ecu.vhdl
-- COMPUERTA AND DE 2 ENTRADAS

library ieee;
use ieee.std_logic_1164.all;

---------------------------------------------------
entity AND2ecu is
	port (a_i   :  in std_logic;
	      b_i   :  in std_logic;
	      y_o   : out std_logic   );
end entity AND2ecu;
---------------------------------------------------
architecture FlujoDeDatos of AND2ecu is begin
	     
	y_o <= a_i and b_i;		
	      
end architecture FlujoDeDatos;
---------------------------------------------------	      	      	      	      