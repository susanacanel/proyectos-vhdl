-- 12.08.20 --------- Susana Canel --------- Rebote.vhdl
-- EJEMPLO DE DESCRIPCION QUE USA UN INTERRUPTOR CON
-- REBOTE. CON CADA ACCION DEL INTERRUPTOR SE INCREMENTA
-- UNA CUENTA EN BINARIO EXHIBIDA POR 4 LEDS.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------
entity Rebote is
  generic(N       : positive := 4);
  port   (boton_i : in  std_logic;
          led_o   : out std_logic_vector(N-1 downto 0));
end entity Rebote;

--------------------------------------------------------
architecture Arq of Rebote is 
  signal cuenta : unsigned (N-1 downto 0);                   
begin
  process (boton_i) begin
    if boton_i='1' then
      cuenta <= cuenta + 1;
    end if;   
  end process;

  led_o <= std_logic_vector(cuenta);  
           
end architecture Arq;
--------------------------------------------------------