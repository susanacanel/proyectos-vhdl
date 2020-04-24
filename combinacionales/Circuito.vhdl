-- 02.04.19 ------------- Susana Canel ------------- Circuito.vhdl
-- DESCRIPCION ESTRUCTURAL DE UN CIRCUITO COMBINACIONAL 
library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------------------
entity Circuito is
   port(a_i, b_i, c_i, d_i  : in  std_logic;
	u_o, v_o	    : out std_logic);
end entity Circuito;
-----------------------------------------------------------------	
architecture Estructural of Circuito is
   --------------------------------------------------------------
   component CompNANDn is
      generic(N          : positive := 4);
      port   (entrada_i  : in  std_logic_vector(N-1 downto 0);
              salida_o   : out std_logic);
   end component CompNANDn;
   --------------------------------------------------------------
   component CompNORn is
      generic(N          : positive := 4);
      port   (entrada_i  : in  std_logic_vector(N-1 downto 0);
              salida_o   : out std_logic);
   end component CompNORn;
   --------------------------------------------------------------
   signal w : std_logic;
begin
u1: CompNANDn generic map(N             => 2)
              port    map(entrada_i(0)  => a_i,
                          entrada_i(1)  => b_i,
                          salida_o      => u_o);
u2: CompNORn  generic map(N             => 2)
              port    map(entrada_i(0)  => b_i,
                          entrada_i(1)  => b_i,
                          salida_o      => w);  
u3: CompNANDn generic map(N             => 3)
              port    map(entrada_i(0)  => w,
                          entrada_i(1)  => c_i,
                          entrada_i(2)  => d_i,
                          salida_o      => v_o);                                                                                                                                                                                                                                     
end architecture Estructural;	
-----------------------------------------------------------------

