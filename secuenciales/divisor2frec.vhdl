-- 19.10.20 ------------------- Susana Canel ------------------ divisor2frec.vhdl 
-- DIVISOR DE FRECUENCIA. GENERA UN RELOJ DE 200 Hz Y OTRO DE 1 Hz.
library ieee;   
use ieee.std_logic_1164.all; 
---------------------------------------------------------------------------------
entity divisor2frec is
  port (clk_i     : in  std_logic;
        rst_i     : in  std_logic; 
        clk1s_o   : out std_logic;  
        clk5ms_o  : out std_logic);   
end entity divisor2frec;
---------------------------------------------------------------------------------
-- LA FRECUENCIA DEL OSCILADOR DE LA PLAQUETA ES DE 24 MHz, DE MANERA QUE PARA
-- OBTENER UNA FRECUENCIA DE 200 Hz (PERIODO DE 5 ms), HAY QUE CONTAR: 
-- 0,005 s * 24.000.000 (1/s) = 120.000 PULSOS, LA MITAD DE ELLOS EN "1" (60.000)
-- Y LOS OTROS 60.000 EN "0".
-- PARA OBTENER UNA FRECUENCIA DE 1 Hz (PERIODO DE 1s) HAY QUE CONTAR: 
-- 1s * 24.000.000 (1/s) = 24.000.000 O SEA 12.000.000 EN "1" Y 12.000.000 EN "0"
-- MAXIMO INTEGER: 2^32/2 = 2.147.483.647;

architecture Arq of divisor2frec is
  type     estado is (inicial, contando);
  signal   proximo       : estado;
  signal   auxClk1s      : std_logic;
  signal   auxclk5ms     : std_logic;
  signal   contador1s    : integer range 0 to 12000000; 
  signal   contador5ms   : integer range 0 to 60000; 
  constant CUENTA1s      : integer := 12000000;
  constant CUENTA5ms     : integer := 60000;
begin
  divisor2frecuencias: 
	process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_i='1' then
        proximo <= inicial;
      else  

        case proximo is
          when inicial =>      
            auxClk1s    <= '0';
            auxclk5ms   <= '0';
            contador5ms <= 0;
            contador1s  <= 0;
            proximo     <= contando;

          when contando =>
            
            -- 5 milisegundos
            if contador5ms>=CUENTA5ms then            
              auxclk5ms   <= not auxclk5ms; 
              contador5ms <= 0; 
            else
              contador5ms <= contador5ms + 1;
            end if;

            -- 1 segundo
            if contador1s>=CUENTA1s then      
              auxClk1s   <= not auxClk1s;
              contador1s <= 0;
            else
              contador1s <= contador1s + 1;
            end if;
            
          when others =>
            proximo <= inicial;
        end case;    
      end if;
    end if;
  end process divisor2frecuencias;

  Salidas: 
  process (auxclk5ms, auxClk1s) is begin
  	clk1s_o  <= auxClk1s;
  	clk5ms_o <= auxclk5ms;
  end process Salidas;
 
end architecture Arq;
---------------------------------------------------------------------------------
