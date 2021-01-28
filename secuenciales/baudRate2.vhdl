-- 20.01.21 ----------------------------- Susana Canel --------------------------- baudRate2.vhdl 
-- DIVISOR DE FRECUENCIA. GENERA UN RELOJ PARA EL BAUD RATE. CREA UN PULSO EN '1' DURANTE UN   
-- CLOCK. GENERA OTRA PULSO DE UNA FRECUENCIA N VECES MAYOR QUE LA DE BAUD RATE.
library ieee;   
use ieee.std_logic_1164.all;   
-------------------------------------------------------------------------------------------------
entity baudRate2 is
  generic (BAUD_RATE    : positive :=9600;             -- bits/s
           N            : positive := 4);              -- N veces el baud rate
  port    (clk_i        : in  std_logic;
           rst_i        : in  std_logic; 
           pulsoBR_o    : out std_logic;        
           pulsoNxBR_o  : out std_logic);   
end entity baudRate2;
-------------------------------------------------------------------------------------------------
-- LA FRECUENCIA DEL OSCILADOR DE LA PLAQUETA ES DE 24 MHz, DE MANERA QUE PARA OBTENER UNA 
-- FRECUENCIA DE 9600 bits/s, HAY QUE CONTAR: 
-- 24.000.000 (1/s) / 9600 (bits/s) = 2500 PULSOS.
-- PARA LA "SENIAL" DE MAYOR FRECUENCIA:
-- 2500 / 8 = 312,5 PULSOS QUE COMO SE TRUNCA A 312 PULSOS, PRODUCE UN DESFASAJE ENTRE AMBAS 
-- "SENIALES", DESFASAJE QUE VA AUMENTANDO AL PASAR EL TIEMPO.

architecture Arq of baudRate2 is
  type     estado is (inicial, contando);
  signal   proximoBR   : estado; 
  constant CUENTA1     : integer := 24000000 / BAUD_RATE;
  signal   contador1   : integer range 0 to CUENTA1;
  constant CUENTA2     : integer := CUENTA1/N;              
  signal   contador2   : integer range 0 to CUENTA2;
begin
  baud: 
	process (clk_i) begin
    if rising_edge(clk_i) then
      if rst_i='1' then
        proximoBR <= inicial;
      else  

        case proximoBR is
          when inicial =>      
               pulsoBR_o   <= '0';
               pulsoNxBR_o <= '0';
               contador1   <= 0;
               contador2   <= 0;
               proximoBR   <= contando;

          when contando =>
          
            -- N x baude rate          
            if contador2>=CUENTA2-1 then 
              pulsoNxBR_o <= '1';
              contador2   <= 0; 
            else
              pulsoNxBR_o <= '0';                       
              contador2   <= contador2 + 1;
            end if;

            -- baude rate
            if contador1>=CUENTA1-1 then 
              pulsoBR_o <= '1';
              contador1 <= 0;
            else
              pulsoBR_o <= '0';                       
              contador1 <= contador1 + 1;
            end if;          

        end case;    
      end if;
    end if;
  end process baud;
 
end architecture Arq;
----------------------------------------------------------------------------
