-- 16.09.18 ---------------- Susana Canel ---------------- Display7segP.vhdl
-- DISPLAY DE 4 DIGITOS DE 7 SEGMENTOS DE LA PLAQUETA DE1 DE ALTERA.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

---------------------------------------------------------------------------
entity Display7segP is
  port(a_i         : in  std_logic_vector(3 downto 0);
       b_i         : in  std_logic_vector(3 downto 0);
       c_i         : in  std_logic_vector(3 downto 0);
       d_i         : in  std_logic_vector(3 downto 0);
       display0_o  : out std_logic_vector(6 downto 0);
       display1_o  : out std_logic_vector(6 downto 0);
       display2_o  : out std_logic_vector(6 downto 0);
       display3_o  : out std_logic_vector(6 downto 0));
end entity Display7segP;

---------------------------------------------------------------------------
-- LOS SEGMENTOS DE LA PLAQUETA SON ACTIVOS EN BAJO, ANODO COMUN.
  
architecture Tabla of Display7segP is
   type     segmentos is array (0 to 15) of std_logic_vector(6 downto 0);
   constant NUM : segmentos := ("0111111",    -- NUM: 0
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
   display0_o <= not NUM(to_integer(unsigned(a_i))); 	 
   display1_o <= not NUM(to_integer(unsigned(b_i)));   
   display2_o <= not NUM(to_integer(unsigned(c_i)));    	 
   display3_o <= not NUM(to_integer(unsigned(d_i)));   	
                              
end architecture Tabla;
---------------------------------------------------------------------------