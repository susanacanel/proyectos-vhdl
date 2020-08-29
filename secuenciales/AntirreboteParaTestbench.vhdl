-- 28.08.20 --------------------- Susana Canel -------------------- Antirrebote.vhdl
-- EJEMPLO DE DESCRIPCION PARA EVITAR EL ANTIRREBOTE, PREPARADO PARA SIMULAR. CAMBIE
-- LA DEMORA DE MANERA QUE ESTE EN EL ORDEN DE LOS ns COMPARABLE CON EL PERIODO DEL
-- CLK.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------------------
entity Antirrebote is
  generic(N       : positive := 4);
  port   (clk_i   : in  std_logic;
          rst_i   : in  std_logic;
          boton_i : in  std_logic;
          led_o   : out std_logic_vector(N-1 downto 0));
end entity Antirrebote;
------------------------------------------------------------------------------------
-- DEMORA DE 12 CLK, DOS CONTADORES ANIDADOS, UNO CUENTA DE 0 A 3 (O SEA 4 CLK) Y EL
-- OTRO CUENTA DE 0 A 2 (O SEA 3 PULSOS DEL CONTADOR1). 4 X 3 = 12 CLK EN TOTAL.

architecture Arq of Antirrebote is 
  type estado is (no_presionado, contando1, contando2, espera_liberacion);
  signal   prox      : estado;
  signal   cuenta    : unsigned (N-1 downto 0); 
  signal   contador1 : integer range 0 to 1024;  -- cuenta 1000 pulsos de clk_i
  signal   contador2 : integer range 0 to 512;   -- cuenta  480 pulsos de contador1
  signal   contador3 : integer range 0 to 65535; -- cuenta clk_i para el simulador
  constant MAX1      : integer := 3;             -- 3 para el simulador, sino 1000
  constant MAX2      : integer := 2;             -- 2 para el simulador, sino 480
begin  
  Secuencial:
  process (clk_i) begin
    if rising_edge(clk_i) then 
      if rst_i='1' then
        prox      <= no_presionado;
        contador1 <= 0;
				contador2 <= 0;
        contador3 <= 0;
        cuenta    <= (others=>'0');
      else
        contador3 <= contador3 + 1;       -- cuenta pulsos de clk_i, para la simulacion
        case prox is

          when no_presionado =>
            if boton_i='1' then
              prox <= contando1;
            else
              prox <= no_presionado;  
            end if;

          when contando1 =>
            if contador1 = MAX1 then       
              contador1 <= 0;  
              if contador2 = MAX2 then
                contador2 <= 0; 
                if boton_i='1' then
                  cuenta <= cuenta + 1;
                  prox   <= espera_liberacion;
                else
                  prox   <= no_presionado;  
                end if;  
              else
                contador2 <= contador2 + 1;
              end if;
            else
              contador1 <= contador1 + 1;
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
------------------------------------------------------------------------------------