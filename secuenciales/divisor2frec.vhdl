-- 12.10.20 ------------------- Susana Canel ------------------ divisor2frec.vhdl 
-- DIVISOR DE FRECUENCIA. GENERA UN RELOJ DE 20ms (NECESARIO PARA EL ANTIRREBOTE)
-- Y OTRO DE 1s.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------------------
entity divisor2frec is
  port (clk_i          : in  std_logic;
        rst_i          : in  std_logic; 
        clk1s_o        : out std_logic;   
        clk20ms_o      : out std_logic);   
end entity divisor2frec;
---------------------------------------------------------------------------------
-- LA FRECUENCIA DEL OSCILADOR DE LA PLAQUETA ES DE 24MHz, DE MANERA QUE PARA
-- OBTENER UNA DEMORA DE 20 ms HAY QUE CONTAR: 0,02s * 24000000 (1/s) = 480000
-- PARA OBTENER UNA DEMORA DE 1 s HAY QUE CONTAR: 1s * 24000000 (1/s) = 24000000
-- MAXIMO INTEGER: 2^32=2147483647;

architecture Arq of divisor2frec is
  type     estado is (inicial, contando);
  signal   prox          : estado;
  signal   auxClk1s      : std_logic;
  signal   auxClk20ms    : std_logic;
  signal   contador1s    : integer range 0 to 24000000; 
  signal   contador20ms  : integer range 0 to 480000; 
  constant CUENTA1s      : integer := 24000000;
  constant CUENTA20ms    : integer := 480000;
begin
  divisor2frecuencias: 
	process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_i='1' then
        prox <= inicial;
      else  

        case prox is
          when inicial =>      
            auxClk1s     <= '0';
            auxClk20ms   <= '0';
            contador20ms <= 0;
            contador1s   <= 0;
            prox         <= contando;

          when contando =>
            
            -- 20 milisegundos
            if contador20ms=CUENTA20ms then            
              auxClk20ms   <= not auxClk20ms; 
              contador20ms <= 0; 
            else
              contador20ms <= contador20ms + 1;
            end if;

            -- 1 segundo
            if contador1s=CUENTA1s then      
              auxClk1s   <= not auxClk1s;
              contador1s <= 0;
            else
              contador1s <= contador1s + 1;
            end if;
            
          when others =>
            prox <= inicial;
        end case;    
      end if;
    end if;
  end process divisor2frecuencias;

  Salidas: 
  process (auxClk20ms, auxClk1s) is begin
  	clk1s_o   <= auxClk1s;
  	clk20ms_o <= auxClk20ms;
  end process Salidas;
 
end architecture Arq;
---------------------------------------------------------------------------------