-- 06.02.21 ----------------- Susana Canel -------------------- rxRS232_2_tb.vhdl
-- TESTBENCH DE RECEPTOR DE LA UART (Universal Asynchronous Receiver/ Transmitter)
-- RS_232. RECIBE CARACTERES DE 8 BITS, CON UN SOLO BIT DE STOP Y SIN BIT DE 
-- PARIDAD, A 115200 BITS/S. 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------
entity rxRS232_2_tb is
end entity rxRS232_2_tb;
----------------------------------------------------------------------------------
architecture Test of rxRS232_2_tb is
  --------------------------------------------------------------------------------
  component rxRS232_2 is
      generic(BITS          : positive := 8);
      port   (clk_i         : in  std_logic;
              rst_i         : in  std_logic;         
              rxd_i         : in  std_logic;         
              caracter_o    : out std_logic_vector(BITS-1 downto 0));   
  end component rxRS232_2;
  --------------------------------------------------------------------------------
  constant NBITS         : integer   := 8;
  signal   clk_t         : std_logic := '1';
  signal   rst_t         : std_logic := '1';
  signal   rxd_t         : std_logic := '1';
  signal   caracter_t    : std_logic_vector(NBITS-1 downto 0);
  constant FRECUENCIA    : integer   := 24;              -- en MHz
  constant PERIODO       : time      := 1 us/FRECUENCIA; -- en ns
  signal   detener       : boolean   := false; 
begin
  dut: rxRS232_2  generic map (BITS       => NBITS)
                port    map (clk_i      => clk_t,
                             rst_i      => rst_t,
                             rxd_i      => rxd_t,        
                             caracter_o => caracter_t);   
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
    report "Verificando el receptor de la UART RS-232, a 115200 bits/s y caracteres ASCII de 8 bits"
    severity note;

    wait until rst_t='0';
    wait for 3 ns;    

    rxd_t <= '1';         -- idle
    wait for 8681 ns;     -- para calcular el tiempo de un bit: (1/115200) = 8680,5555 ns aprox= 8681 ns

    rxd_t <= '0';         -- start
    wait for 8681 ns;

    rxd_t <= '0';         -- bit(0) de la H = "01001000", envío los bits de derecha a izquierda
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(1)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(2)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(3)
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(4)
    wait for 8681 ns;        
    rxd_t <= '0';         -- bit(5)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(6)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(7)
    wait for 8681 ns; 

    rxd_t <= '1';         -- stop
    wait for 8681 ns;   

    rxd_t <= '1';         -- idle
    wait for 8681 ns;

    assert caracter_t = "01001000"
      report "No es una 'H'"
      severity failure;    

    rxd_t <= '0';         -- start
    wait for 8681 ns;

    rxd_t <= '1';         -- bit(0) de la o = "01101111"  
    wait for 8681 ns;    
    rxd_t <= '1';         -- bit(1)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(2)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(3)
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(4)
    wait for 8681 ns;        
    rxd_t <= '1';         -- bit(5)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(6)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(7)
    wait for 8681 ns;   

    rxd_t <= '1';         -- stop
    wait for 8681 ns;   

    rxd_t <= '1';         -- idle
    wait for 8681 ns;
    
    assert caracter_t = "01101111"
      report "No es una 'o'"
      severity failure;

    rxd_t <= '0';         -- falso start
    wait for 2894 ns;
    
    rxd_t <= '1';         -- idle
    wait for 5787 ns;
  
    rxd_t <= '0';         -- start
    wait for 8681 ns;

    rxd_t <= '0';         -- bit(0) de la l = "01101100" 
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(1)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(2)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(3)
    wait for 8681 ns;      
    rxd_t <= '0';         -- bit(4)
    wait for 8681 ns;        
    rxd_t <= '1';         -- bit(5)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(6)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(7)
    wait for 8681 ns;    

    rxd_t <= '1';         -- stop
    wait for 8681 ns; 

    rxd_t <= '1';         -- idle
    wait for 8681 ns;

    assert caracter_t =  "01101100"
      report "No es una 'l'"
      severity failure;

    rxd_t <= '1';         -- idle
    wait for 5787 ns;

    rxd_t <= '0';         -- start
    wait for 8681 ns;

    rxd_t <= '1';         -- bit(0) de la a = "01100001" 
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(1)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(2)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(3)
    wait for 8681 ns;      
    rxd_t <= '0';         -- bit(4)
    wait for 8681 ns;        
    rxd_t <= '1';         -- bit(5)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(6)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(7)
    wait for 8681 ns;    

    rxd_t <= '1';         -- stop
    wait for 8681 ns; 

    rxd_t <= '1';         -- idle
    wait for 8681 ns;

    assert caracter_t =  "01100001"
      report "No es una 'a'"
      severity failure;

    rxd_t <= '0';         -- start
    wait for 8681 ns;

    rxd_t <= '1';         -- bit(0)  "01010101"
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(1)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(2)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(3)
    wait for 8681 ns;      
    rxd_t <= '1';         -- bit(4)
    wait for 8681 ns;        
    rxd_t <= '0';         -- bit(5)
    wait for 8681 ns;
    rxd_t <= '1';         -- bit(6)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(7)
    wait for 8681 ns;    

    rxd_t <= '1';         -- stop
    wait for 8681 ns; 

    rxd_t <= '1';         -- idle
    wait for 8681 ns;

    assert caracter_t = "01010101"
      report "No es un 01010101"
      severity failure;

    rxd_t <= '0';         -- start
    wait for 8681 ns;

    rxd_t <= '1';         -- bit(0) del ! = "00100001" 
    wait for 8681 ns;    
    rxd_t <= '0';         -- bit(1)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(2)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(3)
    wait for 8681 ns;      
    rxd_t <= '0';         -- bit(4)
    wait for 8681 ns;        
    rxd_t <= '1';         -- bit(5)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(6)
    wait for 8681 ns;
    rxd_t <= '0';         -- bit(7)
    wait for 8681 ns;    

    rxd_t <= '1';         -- stop
    wait for 8681 ns; 

    rxd_t <= '1';         -- idle
    wait for 8681 ns;
  
    assert caracter_t =  "00100001" 	
      report "No es un '!'"
      severity failure;

    report "Verificacion exitosa!"
    severity note;
    detener <= true;
    wait;
  
  end process Prueba;                      
end architecture Test;
----------------------------------------------------------------------------------
