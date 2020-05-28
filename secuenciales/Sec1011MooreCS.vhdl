-- 28.05.20 --------- Susana Canel -------- Sec1011MooreCS.vhdl
-- MAQUINA DE ESTADO MOORE. CIRCUITO QUE PONE UN "1" EN SU  
-- SALIDA CUANDO EN LOS ULTIMOS (Y PASADOS) CUATRO CICLOS DE  
-- RELOJ SE HAYA PRESENTADO EN LA ENTRADA LA SECUENCIA 1011.  
-- CON SOLAPAMIENTO. LA ENTRADA ESTA SINCRONIZADA CON EL RELOJ.
library ieee;    
use ieee.std_logic_1164.all;     
---------------------------------------------------------------
entity Sec1011MooreCS is    
   port(clk_i : in  std_logic;    
        rst_i : in  std_logic;       
        dat_i : in  std_logic;            
        sal_o : out std_logic);    
end entity Sec1011MooreCS;    
---------------------------------------------------------------
architecture Arq of Sec1011MooreCS is    
   type   estado is (A,B,C,D,E);    
   signal actual, prox: estado;
begin 
   ------------- PARTE SECUENCIAL -----------------------------   
   Secuencial:    
   process(clk_i) begin 
      if rising_edge(clk_i) then
         if rst_i='1' then         
            actual <= A;  
         else
            actual <= prox;
         end if;
       end if;
   end process Secuencial;

   ------------- PARTE COMBINACIONAL --------------------------	   
   Combinacional:
   process (actual, dat_i) begin
      case actual is    
         when A =>       
            sal_o <= '0';    
            if dat_i='1' then    
               prox <= B;    
            else        
               prox <= A;    
            end if;     
         when B =>   
            sal_o <= '0';
            if dat_i='0' then    
               prox <= C;    
            else        
               prox <= B;    
            end if;     
         when C =>  
            sal_o <= '0';                
            if dat_i='1' then    
               prox <= D;    
            else        
               prox <= A;    
            end if;    
         when D =>    
            sal_o <= '0';            
            if dat_i='1' then    
               prox <= E;    
            else        
               prox <= C;    
            end if;  
         when E =>
            sal_o <= '1';                
            if dat_i='0' then    
               prox <= C;    
            else        
               prox <= B;         
            end if;                                                      
         when others =>  
            sal_o <= '0';  
            prox  <= A;    
      end case;    
   end process Combinacional;        
end architecture Arq;  
---------------------------------------------------------------  