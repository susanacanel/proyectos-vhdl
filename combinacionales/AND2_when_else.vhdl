-- 16.08.18 ------ Susana Canel --------- AND2_when_else.vhd
-- COMPUERTA AND DE 2 ENTRADAS

library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------------
entity AND2_when_else is
	port (a_i	:  in std_logic;
		  b_i	:  in std_logic;
		  y_o	: out std_logic  );
end AND2_when_else;
------------------------------------------------------------
architecture FlujoDeDatos of AND2_when_else is begin

	y_o <= a_i when b_i = '1' else
	       '0';

end architecture FlujoDeDatos;
------------------------------------------------------------