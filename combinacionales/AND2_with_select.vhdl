-- 17.08.18 --- Susana Canel --- AND2_with_select.vhd
-- COMPUERTA AND DE 2 ENTRADAS

library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------
entity AND2_with_select is
	port( a_i   :  in std_logic;
	      b_i   :  in std_logic;
	      y_o   : out std_logic   );
end entity AND2_with_select;

-----------------------------------------------------
architecture TablaDeVerdad of AND2_with_select is
	signal entradas : std_logic_vector(1 downto 0);
begin 
	entradas <= b_i & a_i;
	
	with entradas select
	
	y_o <= '1' when "11",
	       '0' when "01"|"10"|"00",
	       '0' when others;

end architecture TablaDeVerdad;
-----------------------------------------------------
	