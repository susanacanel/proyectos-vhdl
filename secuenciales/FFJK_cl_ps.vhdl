-- 15.08.19 ----- Susana Canel ---- FFJK_cl_ps.vhdl  
-- FLIP-FLOP JK, DISPARADO POR FLANCO POSITIVO, 
-- CLEAR Y PRESET ASINCRONICOS.

library ieee;
use ieee.std_logic_1164.all;
---------------------------------------------------
entity FFJK_cl_ps is
   port(j_i    : in  std_logic;
        k_i    : in  std_logic;
        clk_i  : in  std_logic; 
        cl_i   : in  std_logic;
        ps_i   : in  std_logic; 
        q_o    : out std_logic);
   end entity FFJK_cl_ps;
---------------------------------------------------
architecture Arq of FFJK_cl_ps is
   signal q   : std_logic;
begin

FlipFlopJK:
   process (clk_i, cl_i, ps_i) begin
      if cl_i='1' then
         q <= '0';
      elsif ps_i='1' then
         q <= '1';
      elsif rising_edge(clk_i) then
         q <= (j_i and not q) or (not k_i and q);
      end if;
   end process FlipFlopJK;	

   q_o <= q;

end architecture Arq;
---------------------------------------------------