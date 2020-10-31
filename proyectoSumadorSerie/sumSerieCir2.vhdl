-- 29.10.20 ---------- Susana Canel ---------- sumSerieCir2.vhdl 
-- PARTE DEL CIRCUITO ESTRUCTURAL DE UN SUMADOR SERIE. MODULOS:
-- DIVISOR DE FRECUENCIA, ANTIRREBOTE Y SUMADOR SERIE. 
library ieee;   
use ieee.std_logic_1164.all;
use work.miPackage.all;
----------------------------------------------------------------
entity sumSerieCir2 is
   port   (clk_i     : in  std_logic;
           rst_i     : in  std_logic;   
           boton_i   : in  std_logic;           
           a_i       : in  std_logic_vector(3 downto 0); 
           b_i       : in  std_logic_vector(3 downto 0); 
           s_o       : out std_logic_vector(3 downto 0); 
           led_o     : out std_logic;  
           noBCD_o   : out std_logic;
           c_o       : out std_logic;
           led0_o    : out std_logic;
           led1_o    : out std_logic;
           led2_o    : out std_logic;
           led3_o    : out std_logic);
end entity sumSerieCir2;
----------------------------------------------------------------
architecture Arq of sumSerieCir2 is
  signal clk5ms  : std_logic;
  signal clk1s   : std_logic;
  signal valido  : std_logic;
  signal suma    : std_logic_vector(3 downto 0); 
  signal reg     : std_logic_vector(3 downto 0);   
  signal haySuma : std_logic;  
  signal error   : std_logic;
  signal acarreo : std_logic;
begin
  u1: component divisor2frec port map(clk_i    => clk_i,
                                      rst_i    => rst_i,
                                      clk1s_o  => clk1s,  
                                      clk5ms_o => clk5ms);   

  u2: component antirreboteValida port map(clk_i    => clk5ms,
                                           rst_i    => rst_i,
                                           boton_i  => boton_i,
                                           valido_o => valido);  
                                            
  u3: component sumSerie5 generic map(N             => 4)
						  port    map(clk_i         => clk1s,
									  rst_i         => rst_i,   
                                      pe_i          => valido,
                                      a_i           => a_i,
                                      b_i           => b_i,
                                      suma_o        => suma,
                                      a_o           => reg,
                                      ledSuma_o     => haySuma,
                                      ledError_o    => error,          
                                      ledAcarreo_o  => acarreo); 
                                           
  led0_o  <= reg(0);                                        
  led1_o  <= reg(1);
  led2_o  <= reg(2);
  led3_o  <= reg(3);
  s_o     <= suma;                                         
  led_o   <= haySuma;    
  noBCD_o <= error;                                    
  c_o     <= acarreo;                                           
   
end architecture Arq;
----------------------------------------------------------------
