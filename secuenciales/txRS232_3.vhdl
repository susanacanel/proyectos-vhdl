-- 05.03.21 --------------------------------------- Susana Canel --------------------------------------- txRS232_3.vhdl 
-- TRASMISOR DE LA UART (Universal Asynchronous Receiver/ Transmitter) RS_232. LOS CARACTERES SON DE 8 BITS. 
-- UN BIT DE PARADA. TRANSMITE UN MENSAJE. LA VELOCIDAD DE LA TRANSMISION ES DE 115200 BITS/S. 
 
library ieee;   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------------------------------------------------------------------
entity txRS232_3 is
  generic(BITS        : positive := 8;                  
          BAUD_RATE   : integer  := 115200);
  port   (clk_i       : in  std_logic;
          rst_i       : in  std_logic;
          enviando_i  : in  std_logic;
          txd_o       : out std_logic);   
end entity txRS232_3;
---------------------------------------------------------------------------------------------------------------------
architecture Arq of txRS232_3 is
  type     estado is (idle, bit_start, enviando_bits, bit_stop, espera);
  signal   proximotxd      : estado;

  signal   registrotxd     : std_logic_vector(BITS-1 downto 0);              -- contiene el caracter a transmitir
  signal   contadorBits    : integer range 0 to 8;                           -- 8 bits por caracter y stop
  signal   indice          : integer range 0 to 7;                           -- indice a cada caracter del mensaje
  signal   contadorPulsos  : unsigned(7 downto 0);                           -- para darle el ancho adecuado al bit
  constant CANTIDAD_PULSOS : integer := (24000000/BAUD_RATE);                -- ancho de un bit: frecuencia/baud rate

  type     msj  is array (0 to 7) of std_logic_vector(BITS-1 downto 0);    
  constant MENSAJE: msj := ("01001000",   -- H
                    				"01101111",	  -- o  
                    				"01101100",	  -- l 
                    				"01100001",	  -- a 
                    				"00100001",	  -- ! 	
                    				"00100001",	  -- ! 	
                    				"00001010",   -- LF	
                    				"00001101");  -- CR
begin
  tx: 
  process (clk_i) begin            
    if rising_edge(clk_i) then 
      if rst_i='1' then
        txd_o      <= '1';
        indice     <= 0;
        proximotxd <= idle;
      else
    
        case proximotxd is
        
          when idle =>   
                    txd_o <= '1';
                    if enviando_i='1' then
                        registrotxd <= MENSAJE(indice); 
                        if indice<MENSAJE'length-1 then
                          indice <= indice + 1;
                        else
                          indice <= 0;
                        end if;  
                        contadorPulsos <= (others => '0');
                        contadorBits   <= 0;
                        proximotxd     <= bit_start;
                    end if;
              
          when bit_start =>
                    txd_o      <= '0';
                    proximotxd <= enviando_bits;  
              
          when enviando_bits =>
                    if contadorPulsos<CANTIDAD_PULSOS-1 then       -- genera el ancho del bit       
                        contadorPulsos <= contadorPulsos + 1; 
                    else
                        txd_o          <= registrotxd(contadorBits);
                        contadorPulsos <= (others => '0');          
                        if contadorBits<BITS-1 then
                          contadorBits <= contadorBits + 1;
                        else  
                          contadorBits <= 0;
                          proximotxd   <= bit_stop;
                        end if;  
                    end if;
              
          when bit_stop =>
                    if contadorPulsos<CANTIDAD_PULSOS-1 then           
                        contadorPulsos <= contadorPulsos + 1; 
                    else
                        txd_o          <= '1';   
                        contadorPulsos <= (others => '0');          
                        proximotxd     <= espera; 
                    end if;

          when espera =>                                            -- da el ancho de un bit al pulso del bit de stop
                    if contadorPulsos<CANTIDAD_PULSOS-1 then           
                        contadorPulsos <= contadorPulsos + 1; 
                    else
                        contadorPulsos <= (others => '0');          
                        proximotxd     <= idle; 
                    end if;

          end case;    
      end if;
    end if;
  end process tx; 

end architecture Arq;
---------------------------------------------------------------------------------------------------------------------