-- 21.01.21 ------------------ Susana Canel ---------------------- rxRS232_tb.vhdl
-- TESTBENCH DE RECEPTOR DE LA UART (Universal Asynchronous Receiver/ Transmitter)
-- RS_232. RECIBE CARACTERES DE 8 BITS, CON UN SOLO BIT DE STOP Y SIN BIT DE 
-- PARIDAD, A 9600 BITS/S. USA UNA "SENIAL" PULSANTE DE 8 VECES LA FRECUENCIA DEL 
-- BAUD RATE.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.miPackage.all;
----------------------------------------------------------------------------------
entity rxRS232_tb is
end entity rxRS232_tb;
----------------------------------------------------------------------------------
architecture Test of rxRS232_tb is
  --------------------------------------------------------------------------------
  component rxRS232 is
      generic(BITS          : positive := 8;
              BAUD_RATE     : positive := 9600);
      port   (clk_i         : in  std_logic;
              rst_i         : in  std_logic;         
              rxd_i         : in  std_logic;         
              caracter_o    : out std_logic_vector(BITS-1 downto 0));   
  end component rxRS232;
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
  dut: rxRS232  generic map (BITS       => NBITS)
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
    report "Verificando el receptor de la UART RS-232, a 9600 bits/s y caracteres ASCII de 8 bits"
    severity note;

    wait until rst_t='0';
    wait for 3 ns;    

    rxd_t <= '1';         -- idle
    wait for 104 us;      -- para calcular el tiempo de un bit: (1/9600) = 104,166666 us aprox= 104 us

    rxd_t <= '0';         -- start
    wait for 104 us;

    rxd_t <= '0';         -- bit(0) de la H = "01001000", envío los bits de derecha a izquierda
    wait for 104 us;    
    rxd_t <= '0';         -- bit(1)
    wait for 104 us;
    rxd_t <= '0';         -- bit(2)
    wait for 104 us;
    rxd_t <= '1';         -- bit(3)
    wait for 104 us;    
    rxd_t <= '0';         -- bit(4)
    wait for 104 us;        
    rxd_t <= '0';         -- bit(5)
    wait for 104 us;
    rxd_t <= '1';         -- bit(6)
    wait for 104 us;
    rxd_t <= '0';         -- bit(7)
    wait for 104 us; 

    rxd_t <= '1';         -- stop
    wait for 104 us;   
    
    rxd_t <= '1';         -- idle
    wait for 104 us;

    rxd_t <= '0';         -- start
    wait for 104 us;

    rxd_t <= '1';         -- bit(0) de la o = "01101111"  
    wait for 104 us;    
    rxd_t <= '1';         -- bit(1)
    wait for 104 us;
    rxd_t <= '1';         -- bit(2)
    wait for 104 us;
    rxd_t <= '1';         -- bit(3)
    wait for 104 us;    
    rxd_t <= '0';         -- bit(4)
    wait for 104 us;        
    rxd_t <= '1';         -- bit(5)
    wait for 104 us;
    rxd_t <= '1';         -- bit(6)
    wait for 104 us;
    rxd_t <= '0';         -- bit(7)
    wait for 104 us;   

    rxd_t <= '1';         -- stop
    wait for 104 us;   
    
    rxd_t <= '1';         -- idle    
    wait for 208 us; 

    rxd_t <= '0';         -- falso start
    wait for 40 us;
    
    rxd_t <= '1';         -- idle
    wait for 64 us;

    rxd_t <= '0';         -- start
    wait for 104 us;

    rxd_t <= '0';         -- bit(0) de la l =  "01101100"  
    wait for 104 us;    
    rxd_t <= '0';         -- bit(1)
    wait for 104 us;
    rxd_t <= '1';         -- bit(2)
    wait for 104 us;
    rxd_t <= '1';         -- bit(3)
    wait for 104 us;      
    rxd_t <= '0';         -- bit(4)
    wait for 104 us;        
    rxd_t <= '1';         -- bit(5)
    wait for 104 us;
    rxd_t <= '1';         -- bit(6)
    wait for 104 us;
    rxd_t <= '0';         -- bit(7)
    wait for 104 us;    

    rxd_t <= '1';         -- stop
    wait for 104 us; 

    detener <= true;
    wait;
  end process Prueba;                      
end architecture Test;
----------------------------------------------------------------------------------
