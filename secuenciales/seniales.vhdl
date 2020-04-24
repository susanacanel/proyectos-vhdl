-- 14.05.19 --------------------------------------- Susana Canel ------------------------------------- Seniales.vhdl
-- PROGRAMA VHDL PARA DIBUJAR UNA SERIE DE PULSOS.

library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------------------------------------------------------------
entity Seniales is
end entity Seniales;
--------------------------------------------------------------------------------------------------------------------
architecture Arq of Seniales is 

   signal a   : std_logic := '0';
   signal b   : std_logic := '0';

begin
      -- Como generar una señal de varios pulsos

      a <= '1', '0' after 5 ns, '1' after 10 ns, '0' after 15 ns, '1' after 20 ns, '0' after 25 ns, '1' after 30 ns;
      b <= '1', '0' after 5 ns, '1' after 15 ns, '0' after 30 ns, '1' after 45 ns, '0' after 50 ns, '1' after 55 ns;
            				
end architecture Arq;
--------------------------------------------------------------------------------------------------------------------

