-- 10.10.20 ---------------- Susana Canel ---------------- display7seg.vhd
-- DISPLAY DE 4 DIGITOS DE 7 SEGMENTOS DE LA PLAQUETA DE1 DE ALTERA.
-- RECIBE UN DIGITO BCD.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------------------------
entity display7seg is
  port(a_i       : in  std_logic_vector(3 downto 0);
       b_i       : in  std_logic_vector(3 downto 0);
       c_i       : in  std_logic_vector(3 downto 0);
       d_i       : in  std_logic_vector(3 downto 0);
       dig0_o    : out std_logic_vector(6 downto 0);
       dig1_o    : out std_logic_vector(6 downto 0);
       dig2_o    : out std_logic_vector(6 downto 0);
       dig3_o    : out std_logic_vector(6 downto 0));
end entity display7seg;
---------------------------------------------------------------------------
-- LOS SEGMENTOS DE LA PLAQUETA SON ACTIVOS EN BAJO, ANODO COMUN.
architecture Tabla of display7seg is
	type     segmentos  is array (0 to 15) of std_logic_vector(6 downto 0);
	constant NUM  : segmentos := ("0111111",    -- NUM: 0
            							      "0000110",    -- NUM: 1
            						    	  "1011011",    -- NUM: 2
            						    	  "1001111",    -- NUM: 3
            						    	  "1100110",    -- NUM: 4
            						    	  "1101101",    -- NUM: 5
            							      "1111100",    -- NUM: 6
            						    	  "0000111",    -- NUM: 7
            							      "1111111",    -- NUM: 8
            							      "1101111",    -- NUM: 9
            							      "0000000",    -- NUM: >9 apagado
            							      "0000000",    -- NUM: >9 apagado
            							      "0000000",    -- NUM: >9 apagado
            							      "0000000",    -- NUM: >9 apagado
            							      "0000000",    -- NUM: >9 apagado
            							      "0000000");   -- NUM: >9 apagado
begin	
    dig3_o <= not NUM(to_integer(unsigned(a_i))); 	 
    dig2_o <= not NUM(to_integer(unsigned(b_i)));   
    dig1_o <= not NUM(to_integer(unsigned(c_i)));    	 
    dig0_o <= not NUM(to_integer(unsigned(d_i)));   	
                              
end architecture Tabla;
---------------------------------------------------------------------------