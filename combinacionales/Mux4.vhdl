-- 21.08.18 --------- Susana Canel -------- Mux4.vhdl
-- MULTIPLEXOR DE 4 CANALES

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------
entity Mux4 is
	port(i_i   :  in std_logic_vector(3 downto 0);
             sel_i :  in std_logic_vector(1 downto 0);
             y_o   : out std_logic 
             );
end entity Mux4;
------------------------------------------------------
-- DESCRIPCION USANDO WITH...SELECT

architecture Tabla of Mux4 is begin

	with sel_i select
	y_o <= i_i(0) when "00",
	       i_i(1) when "01",
	       i_i(2) when "10",
	       i_i(3) when others;

end architecture Tabla;
------------------------------------------------------
