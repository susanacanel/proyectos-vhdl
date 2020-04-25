-- 10.05.19 ------ Susana Canel ----- FFD.vhdl  
-- FLIP-FLOP D, DISPARADO POR FLANCO POSITIVO. 

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------
entity FFD is
   port(d_i    : in  std_logic;
        clk_i  : in  std_logic; 
        q_o    : out std_logic);
   end entity FFD;
----------------------------------------------
architecture Arq of FFD is begin

FF_D:
   process (clk_i) begin
      if rising_edge(clk_i) then
         q_o <= d_i ;
      end if;
   end process FF_D;
       
end architecture Arq;
----------------------------------------------
