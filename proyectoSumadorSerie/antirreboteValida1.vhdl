-- 21.10.20 ------------------ Susana Canel ---------------- antirreboteValida1.vhdl
-- ANTIRREBOTE. RECIBE UN RELOJ DE UNA FRECUENCIA DE 200 Hz, PERIODO DE 5 ms.
-- PARA OBTENER UNA DEMORA DE 20 ms HAY QUE CONTAR: 0,02s * 200 (1/s) = 4 PULSOS.
library ieee;  
use ieee.std_logic_1164.all;
-----------------------------------------------------------------------------------
entity antirreboteValida1 is
  port (clk_i    : in  std_logic;
        rst_i    : in  std_logic;
        boton_i  : in  std_logic;
        valido_o : out std_logic);
end entity antirreboteValida1;
-----------------------------------------------------------------------------------
architecture Arq of antirreboteValida1 is 
  type     estado is (no_presionado, contando, espera_liberacion);
  signal   proxEstado  : estado;
  constant PULSOS      : positive := 3;             -- cuenta de 0 a 3 (4 pulsos)
  signal   contador    : integer range 0 to PULSOS;
begin  
  Secuencial:
  process (clk_i, rst_i) begin                      -- reset asincronico
    if rst_i='1' then
      valido_o   <= '0';
      contador   <= 0;        
      proxEstado <= no_presionado;
    elsif rising_edge(clk_i) then 

      case proxEstado is

        when no_presionado =>
            valido_o <= '0';
            contador <= 0;
            if boton_i='1' then
              proxEstado <= contando; 
            else
              proxEstado <= no_presionado;   
            end if;

        when contando =>
            if contador<PULSOS then  
              contador   <= contador + 1;
              proxEstado <= contando;                 
			      else  
              contador <= 0;   
              if boton_i='1' then
                valido_o   <= '1';
                proxEstado <= espera_liberacion;
              else
                proxEstado <= no_presionado;  
              end if;  
			      end if;

        when espera_liberacion =>
            valido_o <= '0';
            if boton_i='0' then   
              proxEstado <= no_presionado;
            else
			        proxEstado <= espera_liberacion;
            end if;    
            
        when others =>
            proxEstado <= no_presionado;  
            
      end case;
        
    end if; 
  end process Secuencial;
           
end architecture Arq;
-----------------------------------------------------------------------------------
