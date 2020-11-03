-- 31.10.20 ---------- Susana Canel ---------- sumSerieCir3.vhdl 
-- PARTE DEL CIRCUITO ESTRUCTURAL DE UN SUMADOR SERIE. MODULOS:
-- DIVISOR DE FRECUENCIA, ANTIRREBOTE Y SUMADOR SERIE. SALIDAS
-- DISPLAY DE 7 SEGMENTOS Y LEDS.
library ieee;   
use ieee.std_logic_1164.all;
use work.miPackage.all;
----------------------------------------------------------------
entity sumSerieCir3 is
   port   (clk_i     : in  std_logic;
           rst_i     : in  std_logic;   
           boton_i   : in  std_logic;           
           a_i       : in  std_logic_vector(3 downto 0); 
           b_i       : in  std_logic_vector(3 downto 0); 
           led_o     : out std_logic;  
           noBCD_o   : out std_logic;
           c_o       : out std_logic;
           ledV_o    : out std_logic_vector(3 downto 0);
           ledR_o    : out std_logic_vector(3 downto 0);
           dig0_o    : out std_logic_vector(6 downto 0);
           dig1_o    : out std_logic_vector(6 downto 0);
           dig2_o    : out std_logic_vector(6 downto 0);
           dig3_o    : out std_logic_vector(6 downto 0));
end entity sumSerieCir3;
----------------------------------------------------------------
architecture Arq of sumSerieCir3 is
  signal clk5ms  : std_logic;
  signal clk1s   : std_logic;
  signal valido  : std_logic;
  signal suma    : std_logic_vector(3 downto 0); 
  signal regA    : std_logic_vector(3 downto 0); 
  signal regB    : std_logic_vector(3 downto 0); 
  signal haySuma : std_logic;  
  signal error   : std_logic;
  signal acarreo : std_logic;
  signal c       : std_logic_vector(3 downto 0); 
  signal d       : std_logic_vector(3 downto 0);  
begin
  u1: component divisor2frec port map(clk_i    => clk_i,
                                      rst_i    => rst_i,
                                      clk1s_o  => clk1s,  
                                      clk5ms_o => clk5ms);   

  u2: component antirreboteValida port map(clk_i    => clk5ms,
                                           rst_i    => rst_i,
                                           boton_i  => boton_i,
                                           valido_o => valido);  
                                            
  u3: component sumSerie6 generic map(N             => 4)
						  port    map(clk_i         => clk1s,
									  rst_i         => rst_i,   
                                      pe_i          => valido,
                                      a_i           => a_i,
                                      b_i           => b_i,
                                      suma_o        => suma,
                                      a_o           => regA,
                                      b_o           => regB,                                      
                                      ledSuma_o     => haySuma,
                                      ledError_o    => error,          
                                      ledAcarreo_o  => acarreo); 
                                      
  u4: component binBCD port map(num_i                   => suma,
                                bcdEmpaq_o(7 downto 4)  => c,         
                                bcdEmpaq_o(3 downto 0)  => d);         

  u5: component display7seg port map(a_i     => a_i,
                                     b_i     => b_i,
                                     c_i     => c,
                                     d_i     => d,
                                     dig0_o  => dig0_o,
                                     dig1_o  => dig1_o,
                                     dig2_o  => dig2_o,
                                     dig3_o  => dig3_o);
                                         
  ledV_o  <= regA;
  ledR_o  <= regB;                                          
  led_o   <= haySuma;    
  noBCD_o <= error;                                    
  c_o     <= acarreo;                                           
   
end architecture Arq;
----------------------------------------------------------------
