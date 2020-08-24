-- 23.08.20 -------------------- Susana Canel ------------------ Antirrebote.vhdl
-- DESCRIPCION PARA EVITAR EL ANTIRREBOTE. CUANDO SE ACCIONA UN INTERRUPTOR SE
-- INCREMENTA EL VALOR DE UNA CUENTA EN BINARIO VISIBLE EN 4 LED.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------------------------------
entity Antirrebote is
  generic(N       : positive := 4);
  port   (clk_i   : in  std_logic;
          rst_i   : in  std_logic;
          boton_i : in  std_logic;
          led_o   : out std_logic_vector(N-1 downto 0));
end entity Antirrebote;
---------------------------------------------------------------------------------
-- LA FRECUENCIA DEL OSCILADOR DE LA PLAQUETA ES DE 24MHz, DE MANERA QUE PARA
-- OBTENER UNA DEMORA DE 20 ms HAY QUE CONTAR: 0,02s * 24000000 (1/s) = 480000
architecture Arq of Antirrebote is 
  type estado is (no_presionado, contando20ms, espera_liberacion);
  signal prox      : estado;
  signal cuenta    : unsigned (N-1 downto 0); 
  signal contador1 : integer range 0 to 1024;  -- cuenta 1000 pulsos de clk_i
  signal contador2 : integer range 0 to 512;   -- cuenta  480 pulsos de contador1
begin  
  Secuencial:
  process (clk_i) begin
    if rising_edge(clk_i) then 
      if rst_i='1' then
        prox      <= no_presionado;
        contador1 <= 0;
		contador2 <= 0;
        cuenta    <= (others=>'0');
      else
        case prox is
          when no_presionado =>
            if boton_i='1' then
              prox <= contando20ms;
            else
              prox <= no_presionado;  
            end if;
          when contando20ms =>
            if contador1=1000 then       
              contador1 <= 0;  
              if contador2=480 then     
                contador2 <= 0; 
                if boton_i='1' then
                  cuenta <= cuenta+1;
                  prox   <= espera_liberacion;
                else
                  prox   <= no_presionado;  
                end if;  
              else
                contador2 <= contador2+1;
              end if;
            else
              contador1 <= contador1+1;
            end if;
          when espera_liberacion =>
            if boton_i='0' then
              prox <= no_presionado;
            else
              prox <= espera_liberacion;
            end if;    
          when others =>
            contador1 <= 0;
            contador2 <= 0;
            prox      <= no_presionado;  
        end case;
      end if;
    end if;                                
  end process Secuencial;
            
  led_o <= std_logic_vector(cuenta);  
           
end architecture Arq;
---------------------------------------------------------------------------------