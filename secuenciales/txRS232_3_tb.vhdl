-- 05.03.21 ---------------------------------------- Susana Canel ---------------------------------------- txRS232_3_tb.vhdl
-- TESTBENCH DEL TRANSMISOR DE UNA UART RS-232. LOS CARACTERES SON DE 8 BITS. UN BIT DE PARADA. TRANSMITE UN MENSAJE. 
-- LA VELOCIDAD DE LA TRANSMISION ES DE 115200 BITS/S. 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------------------------------------------------
entity txRS232_3_tb is
end entity txRS232_3_tb;
--------------------------------------------------------------------------------------------------------------------------
architecture Test of txRS232_3_tb is
  ---------------------------------------------
  component txRS232_3 is
    generic(BITS         : positive := 8;                 
            BAUD_RATE    : integer  := 115200);
    port   (clk_i        : in  std_logic;
            rst_i        : in  std_logic; 
            enviando_i   : in  std_logic;
            txd_o        : out std_logic);    
  end component txRS232_3;
  ---------------------------------------------
  constant BITS          : integer   := 8;
  signal   clk_t         : std_logic := '1';
  signal   rst_t         : std_logic := '1';
  signal   enviando_t    : std_logic := '0';
  signal   txd_t         : std_logic;
  constant FRECUENCIA    : integer   := 24;              -- en MHz
  constant PERIODO       : time      := 1 us/FRECUENCIA; -- en ns
  signal   detener       : boolean   := false; 
begin
  dut : txRS232_3  generic map (BITS       => BITS)              
                   port    map (clk_i      => clk_t,
                                rst_i      => rst_t,
                                enviando_i => enviando_t,        
                                txd_o      => txd_t);   
  -------------------------------------
  GeneraReloj:						  
  process begin 	
    clk_t <= '1', '0' after PERIODO/2;
    wait for PERIODO;
    if detener then
       wait;
    end if;
  end process GeneraReloj;
  -------------------------------------
  rst_t <= '1' , '0' after PERIODO*3/2;

  enviando_t <= '0', '1' after 50 us, '0' after 790 us, '1' after 900 us;

  Prueba:
  process is begin
    report "Verificando el transmisor de la UART RS-232"
    severity note;

    wait until rst_t='0';
    wait for 3 ns;    

    for i in 0 to 23453 loop  -- (ciclo de simulacion de 985000 ns) / (periodo de clock=42 ns (aprox)) = 23453 redondeando
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 2 ns;
    end loop;

    detener <= true;
    wait;
  end process Prueba;                      
end architecture Test;
--------------------------------------------------------------------------------------------------------------------------
