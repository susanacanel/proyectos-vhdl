-- 27.05.19 ----- Susana Canel ---- FFD_cl_en.vhdl  
-- FLIP-FLOP D, DISPARADO POR FLANCO POSITIVO, 
-- CLEAR ASINCRONICO Y HABILITACION.

library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------
entity FFD_cl_en is
   port(d_i    : in  std_logic;
        clk_i  : in  std_logic; 
        cl_i   : in  std_logic;
        en_i   : in  std_logic; 
        q_o    : out std_logic);
   end entity FFD_cl_en;
--------------------------------------------------
architecture Arq of FFD_cl_en is begin

FFD_CLEN:
   process (clk_i, cl_i) begin 
      if cl_i='1' then
         q_o <= '0';
      elsif rising_edge(clk_i) then
         if en_i='1' then
            q_o <= d_i;
         end if;
      end if;   
   end process FFD_CLEN;           
   
end architecture Arq;
---------------------------------------------------
