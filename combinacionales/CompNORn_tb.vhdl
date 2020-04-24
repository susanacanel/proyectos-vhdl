-- 05.04.2019 --------------- Susana Canel ---------------- CompNORn_tb.vhdl
-- TESTBENCH DE UNA COMPUERTA NOR DE 4 ENTRADAS
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------
entity CompNORn_tb is
end entity CompNORn_tb;
----------------------------------------------------------------------------
architecture Test of CompNORn_tb is
   -----------------------------------------------------------  
   component CompNORn is
      generic(N          : positive := 4);
      port   (entrada_i  : in  std_logic_vector(N-1 downto 0);
              salida_o   : out std_logic);
   end component CompNORn;
   -----------------------------------------------------------
   signal a_t : std_logic_vector(3 downto 0):= (others=>'0');
   signal y_t : std_logic;
begin
dut: CompNORn generic map(N          => 4)
              port    map(entrada_i  => a_t,
                          salida_o   => y_t);
Prueba:
   process begin
      report "Verificando la compuerta NOR de 4 entradas"
      severity note;
      	
      a_t <= (others=>'0');
      wait for 1 ns;
      assert y_t = '1'
         report "Falla para a="& integer'image(to_integer(unsigned(a_t)))
         severity failure;

      for i in 1 to 15 loop
         a_t <= std_logic_vector(to_unsigned(i,4));
         wait for 1 ns;
         assert y_t = '0'
            report "Falla para a="& integer'image(to_integer(unsigned(a_t)))
            severity failure;
      end loop;
		  
      report "¡Verificación exitosa!"
      severity note;
      wait;
   end process Prueba;                      	 
end architecture Test;
----------------------------------------------------------------------------
