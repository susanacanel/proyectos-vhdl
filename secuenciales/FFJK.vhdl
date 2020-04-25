-- 15.05.19 ------- Susana Canel ------ FFJK.vhdl  
-- FLIP-FLOP JK, DISPARADO POR FLANCO POSITIVO. 

library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------
entity FFJK is
   port(j_i    : in  std_logic;
        k_i    : in  std_logic;
        clk_i  : in  std_logic; 
        q_o    : out std_logic);
end entity FFJK;
-------------------------------------------------
architecture Arq of FFJK is
   signal q : std_logic;
begin

FlipFlopJK:
   process (clk_i) begin
      if rising_edge(clk_i) then
         q <= (j_i and not q) or (not k_i and q);
      end if;
   end process FlipFlopJK;	

   q_o <= q;

end architecture Arq;
-------------------------------------------------
