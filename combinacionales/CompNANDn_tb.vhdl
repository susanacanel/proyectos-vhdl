-- 06.04.2019 -------------- Susana Canel -------------- CompNANDn_tb.vhdl
-- TESTBENCH DE UNA COMPUERTA NAND GENERICA, DE N ENTRADAS
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------
entity CompNANDn_tb is
end entity CompNANDn_tb;
--------------------------------------------------------------------------
architecture Test of CompNANDn_tb is
   -----------------------------------------------------------  
   component CompNANDn is
      generic(N          : positive := 4);
      port   (entrada_i  : in  std_logic_vector(N-1 downto 0);
              salida_o   : out std_logic);
   end component CompNANDn;
   -----------------------------------------------------------
   signal a_t : std_logic_vector(3 downto 0):= (others=>'0');
   signal y_t : std_logic;
begin
dut: CompNANDn generic map(N          => 4)
               port    map(entrada_i  => a_t,
                           salida_o   => y_t);
Prueba:
   process begin
      report "Verificando la compuerta NAND de 4 entradas"
      severity note;
      
      for i in 0 to 14 loop
         a_t <= std_logic_vector(to_unsigned(i,4));
         wait for 1 ns;
         assert y_t = '1'
            report "Falla para a="& integer'image(to_integer(unsigned(a_t)))
            severity failure;
      end loop;
		
      a_t <= (others=>'1');
      wait for 1 ns;
      assert y_t = '0'
         report "Falla para a="& integer'image(to_integer(unsigned(a_t)))
         severity failure;  
		  
      report "¡Verificación exitosa!"
      severity note;
      wait;
   end process Prueba;                      	 
end architecture Test;
----------------------------------------------------------------------------
