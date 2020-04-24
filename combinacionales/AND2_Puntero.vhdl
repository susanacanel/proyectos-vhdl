-- 17.08.18 ---------- Susana Canel ---------- AND2_Puntero.vhd  
-- COMPUERTA AND DE 2 ENTRADAS

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

----------------------------------------------------------------
entity AND2_Puntero is
 	port(a_i	: in  std_logic;
	     b_i	: in  std_logic;
		 y_o    : out std_logic      );
end entity AND2_Puntero;

----------------------------------------------------------------
-- DESCRIPCIÓN USANDO TABLA DE VERDAD Y PUNTERO (COMPORTAMIENTO)

architecture TablaDeVerdad of AND2_Puntero is 

	signal   entradas  : std_logic_vector(1 downto 0);
	constant COLUMNA   : std_logic_vector(0 to 3) := "0001";
	
begin
	entradas <= b_i & a_i;
	y_o      <= COLUMNA(to_integer(unsigned(entradas)) );
		 
end architecture TablaDeVerdad;
----------------------------------------------------------------
