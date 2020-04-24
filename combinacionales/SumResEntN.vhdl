-- 26.08.18 ---------------- Susana Canel ------------------- SumResEntN.vhdl
-- SUMADOR Y RESTADOR GENERICO DE NUMEROS ENTEROS DE N BITS.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------

entity SumResEntN is
	generic(N     : positive := 3);
	port   (a_i   :  in std_logic_vector(N-1 downto 0);
	        b_i   :  in std_logic_vector(N-1 downto 0);
	        mod_i :  in std_logic;
	        sal_o : out std_logic_vector(N-1 downto 0); -- salida: suma/resta
	        v_o   : out std_logic   );                  -- flag de overflow
end entity SumResEntN;
----------------------------------------------------------------------------
-- MODO=0 SUMA, MODO=1 RESTA. GENERA EL INDICADOR DE DESBORDE: V (OVERFLOW)

architecture Arq of SumResEntN is 
	signal aux : std_logic_vector(N-1 downto 0);
begin
   aux   <= std_logic_vector(signed(a_i) + signed(b_i))    when mod_i='0' ---suma
           else
            std_logic_vector(signed(a_i) - signed(b_i)) ;
           
   v_o   <= (not aux(N-1) and a_i(N-1) and b_i(N-1) )   or 
            (aux(N-1) and not a_i(N-1) and not b_i(N-1))   when mod_i='0' ---suma
           else
            (not aux(N-1) and a_i(N-1) and not b_I(N-1)) or
            (aux(N-1) and not a_i(N-1) and b_i(N-1));
            
   sal_o <= aux;        
           
end architecture Arq;
----------------------------------------------------------------------------
