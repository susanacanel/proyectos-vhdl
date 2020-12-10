-- 30.11.20 ------------------ Susana Canel ------------------- baudRate.vhdl 
-- GENERA UN RELOJ PARA EL BAUD RATE. CREA UNA "SENIAL" PULSANTE, NORMALMENTE 
-- ESTA EN '0' CON UN PULSO EN '1' DURANTE LA DURACIÓN DE UN CLOCK.
library ieee;   
use ieee.std_logic_1164.all;   
-----------------------------------------------------------------------------
entity baudRate is
  port (clk_i    : in  std_logic;
        rst_i    : in  std_logic; 
        pulso_o  : out std_logic);   
end entity baudRate;
-----------------------------------------------------------------------------
-- LA FRECUENCIA DEL OSCILADOR DE LA MI PLAQUETA ES DE 24 MHz, DE MANERA QUE
-- PARA OBTENER UNA FRECUENCIA DE 9600 bits/s, HAY QUE CONTAR: 
-- 24.000.000 (1/s) / 9600 (bits/s) = 2500 PULSOS.

architecture Arq of baudRate is
  type     estadoBaud is (inicial, contando);
  signal   proximoBaud   : estadoBaud;
  constant CUENTA        : integer := 24000000/9600;
  signal   contadorBaud  : integer range 0 to CUENTA;

begin
  baud: 
	process (clk_i) begin
      if rising_edge(clk_i) then
        if rst_i='1' then
          proximoBaud <= inicial;
        else  

        case proximoBaud is
        
          when inicial =>      
               pulso_o      <= '0';
               contadorBaud <= 0;
               proximoBaud  <= contando;

          when contando =>
               if contadorBaud<CUENTA-1 then   
                 contadorBaud <= contadorBaud + 1;         
               else
                 pulso_o     <= '1'; 
                 proximoBaud <= inicial;
               end if;

        end case;    
      end if;
    end if;
  end process baud;
 
end architecture Arq;
-----------------------------------------------------------------------------
