-- 22.06.2020 ------------- Susana Canel ------------- ContadorSec.vhdl
-- CONTADOR DE 3 BITS, CUENTA EN LA SECUENCIA: 4,3,7,1,0. 
-- SI SE PRODUCE UN ESTADO INDESEADO, EN UN PERIODO DE RELOJ ENTRA EN 
-- SECUENCIA. EL RESET SINCRONICO DA EL ESTADO INICIAL. 

library ieee;  
use ieee.std_logic_1164.all;

--------------------------------------------------------------------
entity ContadorSec is
   port(rst_i : in  std_logic;
        clk_i : in  std_logic;
        q_o   : out std_logic_vector(2 downto 0));
end entity ContadorSec;

--------------------------------------------------------------------
architecture Arq of ContadorSec is 
   signal auxQ : std_logic_vector(2 downto 0);
begin
   process (clk_i) begin
      if rising_edge(clk_i) then 	  
         if rst_i='1' then
            auxQ <= "100";
         else
            case auxQ is
               when "100" =>		
                  auxQ <= "011";
               when "011"  =>		
                  auxQ <= "111";
               when "111"  =>			
                  auxQ <= "001";
               when "001"  =>
                  auxQ <= "000";
               when "000"  =>
                  auxQ <= "100";				
               when others =>
                  auxQ <= "100";
            end case;			
         end if;
      end if;
   end process;
   
   q_o <= auxQ;
   
end architecture Arq;
-------------------------------------------------------------------- 