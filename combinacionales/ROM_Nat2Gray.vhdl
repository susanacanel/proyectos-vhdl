-- 30.03.19 ------------------ Susana Canel ------------------ ROM_Nat2Gray.vhdl
-- CONVERSOR DE BINARIO NATURAL A GRAY DE 4 BITS IMPLEMENTADO CON UNA ROM.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--------------------------------------------------------------------------------
entity ROM_Nat2Gray is
   generic (BITS   : integer := 4; 	 -- 4 bits por palabra
            DIREC  : integer := 4); 	 -- 4 lineas de direcciones: 16 palabras
   port    (dir_i : in  std_logic_vector(DIREC-1 downto 0);
            ena_i : in  std_logic;
            dat_o : out std_logic_vector(BITS-1 downto 0)
	   );
end entity ROM_Nat2Gray;

--------------------------------------------------------------------------------
-- SI NO ESTA HABILITADA PONE LA SALIDA EN ALTA IMPEDANCIA. 

architecture ArqROM of ROM_Nat2Gray is

   type   rom_16x4  is array (0 to 15) of std_logic_vector(3 downto 0);
	
   constant ROM: rom_16x4 := ("0000",    -- dir: 0 contenido:  0
			      "0001",	 -- dir: 1 contenido:  1
			      "0011",	 -- dir: 2 contenido:  3
			      "0010",	 -- dir: 3 contenido:  2
			      "0110",	 -- dir: 4 contenido:  6
			      "0111",	 -- dir: 5 contenido:  7
			      "0101",	 -- dir: 6 contenido:  5
			      "0100",	 -- dir: 7 contenido:  4
			      "1100",	 -- dir: 8 contenido: 12
			      "1101",    -- dir: 9 contenido: 13
			      "1111",    -- dir:10 contenido: 15
			      "1110",    -- dir:11 contenido: 14
			      "1010",    -- dir:12 contenido: 10
			      "1011",    -- dir:13 contenido: 11
			      "1001",    -- dir:14 contenido:  9
			      "1000" );  -- dir:15 contenido:  8							              										   	
begin
   dat_o <= ROM(to_integer(unsigned(dir_i))) when ena_i='1' else
	    "ZZZZ";               
	                              
end architecture ArqROM;
--------------------------------------------------------------------------------
