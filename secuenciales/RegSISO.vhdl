-- 04.11.19 -------- Susana Canel -------- RegSISO.vhdl
-- REGISTRO SISO, DESPLAZAMIENTO A DERECHA, GENERICO, 
-- SINCRONICO. 

library ieee;   
use ieee.std_logic_1164.all;
-------------------------------------------------------
entity RegSISO is
   generic(N     : positive := 5);
   port   (clk_i : in  std_logic;
           si_i  : in  std_logic;
           q_o   : out std_logic_vector(N-1 downto 0));
end entity RegSISO;
-------------------------------------------------------
architecture Arq of RegSISO is
   signal auxQ : std_logic_vector(N-1 downto 0);
begin
   Registro: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         auxQ <= si_i & auxQ(N-1 downto 1);
      end if;
   end process Registro;
   
   q_o <= auxQ;
   
end architecture Arq;
-------------------------------------------------------
