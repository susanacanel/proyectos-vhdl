-- 11.02.21 ------------------------------- Susana Canel -------------------------------------- rxRS232_2.vhdl 
-- RECEPTOR DE LA UART (Universal Asynchronous Receiver/ Transmitter) RS_232. RECIBE CARACTERES DE 8 BITS, 
-- CON UN SOLO BIT DE STOP Y SIN BIT DE PARIDAD. USA UN UNICO RELOJ. BAUD RATE = 115200 BPS.

library ieee;   
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
--------------------------------------------------------------------------------------------------------------
entity rxRS232_2 is
  generic(BITS          : positive := 8);
  port   (clk_i         : in  std_logic;
          rst_i         : in  std_logic;         
          rxd_i         : in  std_logic;         
          caracter_o    : out std_logic_vector(BITS-1 downto 0));   
end entity rxRS232_2;
--------------------------------------------------------------------------------------------------------------
architecture Arq of rxRS232_2 is
  type     estado is (idle, validando_start, recibiendo_bit, recibiendo_stop);
  signal   proximoRx         : estado;
  signal   registroRx        : std_logic_vector(BITS-1 downto 0);
  signal   bufferRx          : std_logic_vector(BITS-1 downto 0);  
  signal   contadorBits      : unsigned(4 downto 0);                  -- dimension mayor de la necesaria
  signal   contadorPulsos    : unsigned(12 downto 0);                 -- dimension mayor de la necesaria
  constant BAUD_RATE         : integer := 115200;
  constant CANTIDAD_PULSOS   : integer := (24000000/BAUD_RATE) - 1;   -- para posicionarse en la mitad del bit
begin                                                                                                         
  rx: 
  process (clk_i) begin   
    if rising_edge(clk_i) then                   
      if rst_i='1' then
       registroRx <= (others => '0');
       bufferRx   <= (others => '0');
       proximoRx  <= idle;
      else
              
        case proximoRx is
        
          when idle =>  
             contadorBits    <= (others => '0');
             contadorPulsos  <= (others => '0');
             registroRx      <= (others => '0');            
             if rxd_i='0' then            
                proximoRx <= validando_start;            
             end if;                                    	

          when validando_start => 
             if contadorPulsos<(CANTIDAD_PULSOS/2) then           -- se posiciona en la mitad del bit
                contadorPulsos <= contadorPulsos + 1; 
             else
                contadorPulsos <= (others => '0');
                if rxd_i='0' then            
                   proximoRx <= recibiendo_bit;     
                else
                   proximoRx <= idle;
                end if; 
             end if;                                      

          when recibiendo_bit =>   
             if contadorPulsos<CANTIDAD_PULSOS then  
                contadorPulsos <= contadorPulsos + 1; 
             else
                contadorPulsos <= (others => '0');
                if contadorBits<BITS then                                                                  
                   registroRx     <= rxd_i & registroRx(BITS-1 downto 1);                                           
                   contadorBits   <= contadorBits + 1;
                else
                   contadorBits   <= (others => '0');
                   proximoRx      <= recibiendo_stop;
                end if; 
             end if;
            	  
          when recibiendo_stop => 
             if contadorPulsos<CANTIDAD_PULSOS then 
                contadorPulsos <= contadorPulsos + 1;                        
             else
                contadorPulsos <= (others => '0');                                                                               
                bufferRx       <= registroRx;  
                proximoRx      <= idle; 
             end if;
              
        end case;    
      end if;
    end if;
  end process rx; 
  
  caracter_o <= bufferRx;

end architecture Arq;
--------------------------------------------------------------------------------------------------------------
