-- 05.05.20 --------------- Susana Canel ------------- Sec1011MealyCS.vhdl
-- MAQUINA DE ESTADO MEALY. CIRCUITO QUE PONE UN "1" EN SU SALIDA CUANDO
-- EN LOS ULTIMOS (Y PASADOS) TRES CICLOS DE RELOJ SE HAYA PRESENTADO EN
-- LA ENTRADA LA SECUENCIA 101 Y AHORA HAYA UN 1 EN LA ENTRADA. LA ENTRADA 
-- ESTA SINCRONIZADA CON EL RELOJ. CON SOLAPAMIENTO. 
 
library ieee;  
use ieee.std_logic_1164.all;
--------------------------------------------------------------------------
entity Sec1011MealyCS is
   port(dat_i : in  std_logic; 
        rst_i : in  std_logic;
        clk_i : in  std_logic;
        sal_o : out std_logic);
end Sec1011MealyCS;
--------------------------------------------------------------------------
architecture Arq of Sec1011MealyCS is 
   type   estado is (A, B, C, D);
   signal actual, prox: estado;
begin
   --------------------------- PARTE SECUENCIAL --------------------------
   Secuencial:
   process (clk_i) begin
      if rising_edge(clk_i) then 
         if rst_i='1' then
            actual <= A;
         else
            actual <= prox;
         end if;
      end if;
   end process Secuencial;
   
   -------------------------- PARTE COMBINACIONAL ------------------------
   Combinacional:
   process (dat_i, actual) begin
      sal_o <='0';
      case actual is
         when A =>			
            if dat_i='1' then
               prox <= B;
            else         
               prox <= A;
            end if;
         when B =>
            if dat_i='0' then 
               prox <= C;
            else    
               prox <= B;
            end if;
         when C =>
            if dat_i='1' then
               prox <= D;
            else    
               prox <= A;
            end if;
         when D =>
            if dat_i='1' then
               prox  <= B;
               sal_o <='1';       -- se activa la salida
            else 
               prox  <= C;   	
            end if;	
         when others =>
            prox  <= A;
      end case;
   end process Combinacional;
end architecture Arq;
-------------------------------------------------------------------------- 