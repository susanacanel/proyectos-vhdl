-- 06.05.19 --------- Susana Canel -------- LatchD.vhdl
-- LATCH D CON HABILITACION.

library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------
entity LatchD is
   port(d_i   : in  std_logic;
        le_i  : in  std_logic;
        q_o   : out std_logic);
end entity LatchD;

--------------------------------------------------------
-- CUANDO LE=0, Q RETIENE SU VALOR SE LOGRA AL NO 
-- ESPECIFICAR QUE SUCEDE EN ESE CASO. EL "WHEN" SIN EL 
-- "ELSE" QUE CONTEMPLE TODOS LOS CASOS INFIERE MEMORIA.

architecture Arq of LatchD is begin

   q_o <= d_i when le_i='1';
				
end architecture Arq;
---------------------------------------------------------
