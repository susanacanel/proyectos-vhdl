-- 13.03.20 ------- Susana Canel ------ ContAnillo.vhdl
-- CONTADOR EN ANILLO CON ARRANQUE AUTOMATICO.

library ieee;   
use ieee.std_logic_1164.all;
-------------------------------------------------------
entity ContAnillo is
   generic(N     : positive := 6);
   port   (clk_i : in  std_logic; 
           rst_i : in  std_logic; 
           sel_i : in  std_logic_vector(1 downto 0);					 
           q_o   : out std_logic_vector(N-1 downto 0)); 
end entity ContAnillo;
-------------------------------------------------------
architecture Arq of ContAnillo is
   signal auxQ : std_logic_vector(N-1 downto 0); 
   signal q    : std_logic;
begin
Realimenta:
   process (clk_i) is
   begin
      if rising_edge(clk_i) then
         if rst_i ='1' and sel_i="00" then
            auxQ(N-2 downto 0) <= (others => '0');   
            auxQ(N-1)          <= '1';
         elsif rst_i ='1' and sel_i="11" then
            auxQ(N-1 downto 0) <= (others => '1');   
         elsif rst_i ='1' and sel_i="01" then
            auxQ(N-1 downto 0) <= "10111";
         elsif rst_i ='1' and sel_i="10" then
            auxQ(N-1 downto 0) <= (others => '0');   
         else
            auxQ  <= q & auxQ(N-1 downto 1);     
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
         q   <= not aux;
   end loop;
   end process AutoCorreccion;
	
   q_o <= auxQ;
	
end architecture Arq;
-------------------------------------------------------
 