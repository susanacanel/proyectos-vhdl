-- 22.08.19 ------------ Susana Canel ------------- ContMpot2Q.vhdl
-- CONTADOR SINCRONICO BINARIO, DE N BITS, MODULO POTENCIA DE 2.
-- SALIDA: CUENTA.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------
entity ContMpot2Q is
   generic(N     : positive := 3);
   port   (clk_i : in  std_logic;
           q_o   : out std_logic_vector(N-1 downto 0));
end entity ContMpot2Q;

-------------------------------------------------------------------
-- EJEMPLO: PARA N=3, CUENTA DESDE 000 A 111 (0 A 7) ==> MODULO M=8

architecture Arq of ContMpot2Q is 
   signal auxQ : unsigned (N-1 downto 0);                   
begin
   Contador:
   process (clk_i) begin
      if rising_edge(clk_i) then
         auxQ <= auxQ + 1;
      end if;   
   end process Contador;

   q_o <= std_logic_vector(auxQ);  
           
end architecture Arq;
-------------------------------------------------------------------
