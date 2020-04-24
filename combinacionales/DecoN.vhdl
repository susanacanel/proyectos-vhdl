-- 27.08.18 ----------- Susana Canel ------------ DecoN.vhdl
-- DECODIFICADOR GENERICO DE N BITS CON HABILITACION.
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

-----------------------------------------------------------
entity DecoN is
   generic(N     : positive :=3); 
   port   (a_i   :  in std_logic_vector(N-1    downto 0);
           ena_i :  in std_logic;
           y_o   : out std_logic_vector(2**N-1 downto 0)
          ); 
end entity DecoN;
-----------------------------------------------------------
-- HABILITACION Y SALIDA ACTIVAS EN ALTO.

architecture Proceso of DecoN is begin 

   process (a_i, ena_i) is begin
      y_o                            <= (others => '0');
      y_o(to_integer(unsigned(a_i))) <= ena_i; 
   end process;
	 
end architecture Proceso;
-----------------------------------------------------------
