-- 08.01.21 ------------------ Susana Canel ---------------------- txRS232_tb.vhdl
-- TESTBENCH DEL TRANSMISOR DE UNA UART RS-232.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.miPackage.all;
----------------------------------------------------------------------------------
entity txRS232_tb is
end entity txRS232_tb;
----------------------------------------------------------------------------------
architecture Test of txRS232_tb is
  --------------------------------------------------------------------------------
  component txRS232 is
    generic(BITS       : positive := 8;
            BAUD_RATE  : positive := 9600);                -- bits/s
    port   (clk_i      : in  std_logic;
            rst_i      : in  std_logic; 
            enviando_i : in  std_logic;
            dat_o      : out std_logic);   
  end component txRS232;
  --------------------------------------------------------------------------------
  signal   clk_t         : std_logic := '1';
  signal   rst_t         : std_logic := '1';
  signal   enviando_t    : std_logic := '0';
  signal   dat_t         : std_logic;
  constant FRECUENCIA    : integer   := 24;              -- en MHz
  constant PERIODO       : time      := 1 us/FRECUENCIA; -- en ns
  signal   detener       : boolean   := false; 
begin
  dut : txRS232  generic map (BITS       => 8,
                              BAUD_RATE  => 9600)              
                 port    map (clk_i      => clk_t,
                              rst_i      => rst_t,
                              enviando_i => enviando_t,        
                              dat_o      => dat_t);   
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

  Prueba:
  process is begin
    report "Verificando el transmisor de la UART RS-232"
    severity note;

    wait until rst_t='0';
    wait for 3 ns;    
    
    enviando_t <= '1';
 
    for i in 0 to 93000 loop
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 2 ns;
    end loop;

    detener <= true;
    wait;
  end process Prueba;                      
end architecture Test;
----------------------------------------------------------------------------------
