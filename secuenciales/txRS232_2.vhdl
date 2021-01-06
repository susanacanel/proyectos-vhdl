-- 22.12.20 ----------------------------- Susana Canel ------------------------- txRS232_2.vhdl 
-- TRASMISOR DE LA UART (Universal Asynchronous Receiver/ Transmitter) RS_232. LOS 
-- CARACTERES SON DE 8 BITS. UN BIT DE PARADA. TRANSMITE UN MENSAJE. 

library ieee;   
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.miPackage.all;
---------------------------------------------------------------------------------------------
entity txRS232_2 is
  generic(BITS       : positive := 8;
          BAUD_RATE  : positive := 9600);                -- bits/s
  port   (clk_i      : in  std_logic;
          rst_i      : in  std_logic; 
          enviando_i : in  std_logic;
          dat_o      : out std_logic);   
end entity txRS232_2;
---------------------------------------------------------------------------------------------
architecture Arq of txRS232_2 is
  type     estado is (idle, start, enviando_datos, stop);
  signal   proximoTx   : estado;
  signal   pulsoTx     : std_logic;
  signal   registroTx  : std_logic_vector(BITS-1 downto 0);
  signal   contadorTx  : unsigned(3 downto 0);          -- hasta 16 bits por caracter
  signal   i           : integer range 0 to 32;         -- indice a cada caracter del mensaje
  type     msj  is array (0 to 6) of std_logic_vector(BITS-1 downto 0);
  constant MENSAJE: msj := ("01001000",   -- H
                    				"01101111",	  -- o  
                    				"01101100",	  -- l 
                    				"01100001",	  -- a 
                    				"00100001",	  -- ! 	
                    				"00001010",   -- LF	
                    				"00001101");  -- CR																								
begin
  dut: component baudRate2 generic map (BAUD_RATE  => 9600)
                           port    map (clk_i      => clk_i,
                                        rst_i      => rst_i,
                                        pulsoBR_o  => pulsoTx);  			              										   	
  tx: 
  process (pulsoTx, rst_i) begin            -- reset asincronico
    if rst_i='1' then
        proximoTx  <= idle;
        contadorTx <= (others => '0');
        registroTx <= (others => '0');
        dat_o      <= '1';
        i          <= 0;
    elsif rising_edge(pulsoTx) then 
    
      case proximoTx is
        
        when idle =>      
                  if enviando_i='1' then
                    registroTx <= MENSAJE(i); 
                    dat_o      <= '1';
                    proximoTx  <= start;
                    i          <= i + 1;
                    if i>=MENSAJE'length then
                      i <= 0;
                    end if;  
                  end if;
            
        when start =>
                  dat_o      <= '0';
                  contadorTx <= (others => '0');
                  proximoTx  <= enviando_datos;          
            
        when enviando_datos =>
                  contadorTx <= contadorTx + 1;
                  dat_o      <= registroTx(0);
                  registroTx <= registroTx(0) & registroTx(BITS-1 downto 1);
                  if contadorTx>=BITS-1 then
                    proximoTx <= stop;
                  end if;  
            
        when stop =>
                  dat_o     <= '1';            
                  proximoTx <= idle; 
    
      end case;    
    end if;
  end process tx; 

end architecture Arq;
---------------------------------------------------------------------------------------------
