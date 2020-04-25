-- 28.03.20 ----------- Susana Canel ----------- JohnsonM8.vhdl
-- CONTADOR JOHNSON MODULO PAR CON ARRANQUE AUTOMATICO, 
-- EN MENOS DE (N-1) PULSOS DE RELOJ ENTRA EN SECUENCIA.

library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------
entity Johnson is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic; 
           rst_i : in  std_logic; 					 
           q_o   : out std_logic_vector(N-1 downto 0)); 
end entity Johnson;
---------------------------------------------------------------
architecture Arq of Johnson is
   signal auxQ : std_logic_vector(N-1 downto 0);
begin
Realimenta:
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i ='1' or (auxQ(1)= '0' and auxQ(0)= '1') then
            auxQ <= (others => '0');
         else
            auxQ <= not auxQ(0) & auxQ(N-1 downto 1);
         end if;
      end if;
   end process Realimenta;
   	
   q_o <= auxQ;
	
end architecture Arq;
---------------------------------------------------------------
  