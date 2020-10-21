-- 15.10.20 ---------- Susana Canel ---------- sumSerieCir1.vhdl 
-- CIRCUITO ESTRUCTURAL DE UN SUMADOR SERIE. MODULO  CON EL 
-- DIVISOR DE FRECUENCIA Y EL ANTIRREBOTE. 
library ieee;   
use ieee.std_logic_1164.all;
use work.miPackage.all;
----------------------------------------------------------------
entity sumSerieCir1 is
   port   (clk_i      : in  std_logic;
           rst_i      : in  std_logic;   
           boton_i    : in  std_logic;           
           led1s_o    : out std_logic;           
           ledVal_o   : out std_logic );
end entity sumSerieCir1;
----------------------------------------------------------------
architecture Arq of sumSerieCir1 is
  signal clk5ms  : std_logic;
  signal clk1s   : std_logic;
  signal valido  : std_logic;
begin
  u1: component divisor2frec      port map(clk_i    => clk_i,
                                           rst_i    => rst_i,
                                           clk1s_o  => clk1s,  
                                           clk5ms_o => clk5ms);   

  u2: component antirreboteValida port map(clk_i    => clk5ms,
                                           rst_i    => rst_i,
                                           boton_i  => boton_i,
                                           valido_o => valido);   
  led1s_o  <= clk1s;  
  ledVal_o <= valido;
   
end architecture Arq;
----------------------------------------------------------------
