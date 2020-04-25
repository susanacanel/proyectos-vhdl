-- 09.05.19 --- Susana Canel --- LatchSR_rstPr.vhdl
-- LATCH SR CON RESET PRIORITARIO

library ieee;
use ieee.std_logic_1164.all;
---------------------------------------------------
entity LatchSR_rstPr is
   port(r_i : in  std_logic;
        s_i : in  std_logic;
        q_o : out std_logic);
end entity LatchSR_rstPr;

---------------------------------------------------
-- LA PRIORIDAD LA FIJA EL ORDEN DE LOS "WHEN".
-- SI R=S=0, Q RETIENE SU VALOR (MEMORIZA)

architecture Arq of LatchSR_rstPr is begin

   q_o <= '0' when r_i = '1' else
          '1' when s_i = '1';
				
end architecture Arq;
---------------------------------------------------
