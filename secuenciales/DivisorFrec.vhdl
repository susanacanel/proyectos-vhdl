-- 08.08.20 ---------------------- Susana Canel ---------------------- DivisorFrec.vhdl 
-- DIVISOR DE FRECUENCIA POR 24. ESTA HECHO CON DOS CONTADORES ANIDADOS, UNO CUENTA  
-- 2 PULSOS Y EL OTRO CUENTA 6 PULSOS DEL PRIMERO. OTRO CONTADOR AYUDA A CONFIRMAR LA 
-- FRECUENCIA OBTENIDA. LA IDEA ES TENER UN MODULO PARA HACER CONTADORES QUE DIVIDAN 
-- FRECUENCIAS DE MHz A Hz.

library ieee;   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------------------------------------
entity DivisorFrec is
  port (clk_i : in  std_logic;
        clr_i : in  std_logic;
        clk_o : out std_logic);
end entity DivisorFrec;
---------------------------------------------------------------------------------------
architecture Arq of DivisorFrec is 
  signal auxClko    : std_logic;
  signal contador1  : integer range 0 to 255;
  signal contador2  : integer range 0 to 255;
  signal contador3  : integer range 0 to 32767; -- cuenta pulsos del clock 
                                                -- del sistema p/confirmar 
                                                -- la frecuencia obtenida
begin
  DivisorFrecuencia: 
	process (clk_i) begin
    if rising_edge(clk_i) then
      if clr_i='1' then
        auxClko   <='0';
        contador1 <= 0;
        contador2 <= 0;
        contador3 <= 0;            
      else  
        contador3 <= contador3 + 1;       -- cuenta pulsos de clk_i, para la simulacion
        if contador1 < 1 then             -- cuenta 2 pulsos de clk_i, de 0 a 1
          contador1 <= contador1 + 1;
        else
          contador1 <= 0;
          if contador2 < 5 then           -- cuenta 6 pulsos de contador1, de 0 a 5
            contador2 <= contador2 + 1;
          else  
            contador2 <= 0;
            auxClko <= not auxClko;
          end if;
        end if;
      end if;
    end if;
  end process DivisorFrecuencia;

  clk_o <= auxClko;

end architecture arq;
---------------------------------------------------------------------------------------