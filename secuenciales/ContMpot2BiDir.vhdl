-- 18.09.19 ------ Susana Canel ------ contmpot2bidir.vhdl
-- CONTADOR GENERICO, SINCRONICO, BINARIO, BIDIRECCIONAL,  
-- MODULO POTENCIA DE 2, HABILITACION Y RESET SINCRONICOS.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------
entity contmpot2bidir is
   generic(N     : positive := 3);
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;
           ena_i : in  std_logic;
           up_i  : in  std_logic;              
           q_o   : out std_logic_vector(N-1 downto 0));
end entity contmpot2bidir;
----------------------------------------------------------
architecture Arq of contmpot2bidir is 
   signal auxQ : signed(N-1 downto 0);
   signal dir  : integer range -1 to 1;
begin
   dir <= 1 when up_i='1' else -1;

   Contador: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' then
            auxQ <= (others => '0');
         elsif ena_i='1' then
            auxQ <= auxQ + dir;        
         end if;
      end if;
   end process Contador;

   q_o <= std_logic_vector(auxQ);

end architecture Arq;
----------------------------------------------------------
