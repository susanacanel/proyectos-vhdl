-- 15.10.19 -------- Susana Canel -------- RegSinc.vhdl
-- REGISTRO GENERICO, SINCRONICO, CON RESET SINCRONICO

library ieee;   
use ieee.std_logic_1164.all;
-------------------------------------------------------
entity RegSinc is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;
           d_i   : in  std_logic_vector(N-1 downto 0);
           q_o   : out std_logic_vector(N-1 downto 0));
end entity RegSinc;
-------------------------------------------------------
architecture Arq of RegSinc is begin

   Reg: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' then
            q_o <= (others => '0');
         else
            q_o <= d_i;
         end if;
      end if;
   end process Reg;
   
end architecture Arq;
-------------------------------------------------------

