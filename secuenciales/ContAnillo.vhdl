-- 07.02.20 ------- Susana Canel ------ ContAnillo.vhdl
-- CONTADOR EN ANILLO CON ARRANQUE AUTOMATICO.
library ieee;   
use ieee.std_logic_1164.all;
-------------------------------------------------------
entity ContAnillo is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic; 
           rst_i : in  std_logic; 					 
           q_o   : out std_logic_vector(N-1 downto 0)); 
end entity ContAnillo;
-------------------------------------------------------
architecture Arq of ContAnillo is
   signal auxQ : std_logic_vector(N-1 downto 0); 
   signal q    : std_logic;
begin
Realimenta:
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' then
            auxQ(N-2 downto 0) <= (others =>'0');
            auxQ(N-1)          <= '1';
         else
            auxQ <= q & auxQ(N-1 downto 1);     
         end if;
      end if;
   end process Realimenta;
   
AutoCorreccion:   
   process (auxQ) is
      variable aux : std_logic; 
   begin
      aux := '0';
      for i in 1 to N-1 loop
         aux := aux or auxQ(i);
      end loop;
         q <= not aux;
   end process AutoCorreccion;
	
   q_o <= auxQ;
	
end architecture Arq;
-------------------------------------------------------


 