-- 21.01.21 -------------------------------- Susana Canel --------------------------------------- rxRS232.vhdl 
-- RECEPTOR DE LA UART (Universal Asynchronous Receiver/ Transmitter) RS_232.
-- RECIBE CARACTERES DE 8 BITS, CON UN SOLO BIT DE STOP Y SIN BIT DE PARIDAD. A 9600 BITS/S.

library ieee;   
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.miPackage.all;
--------------------------------------------------------------------------------------------------------------
entity rxRS232 is
  generic(BITS          : positive := 8;
          BAUD_RATE     : positive := 9600);
  port   (clk_i         : in  std_logic;
          rst_i         : in  std_logic;         
          rxd_i         : in  std_logic;         
          caracter_o    : out std_logic_vector(BITS-1 downto 0));   
end entity rxRS232;
--------------------------------------------------------------------------------------------------------------
architecture Arq of rxRS232 is
  type     estado is (idle, validando_start, recibiendo_bit, recibiendo_stop);
  signal   proximoRx         : estado;
  signal   pulsoN            : std_logic;
  signal   registroRx        : std_logic_vector(BITS-1 downto 0);
  signal   bufferRx          : std_logic_vector(BITS-1 downto 0);  
  signal   contadorBits      : unsigned(4 downto 0);           
  signal   contadorPulsos    : unsigned(5 downto 0);                -- dimension mayor de la necesaria
  constant N                 : integer := 8;                        -- N veces la frecuencia del baud rate
  constant CANTIDAD_PULSOS   : integer := N - 1;                    -- para posicionarse en la mitad del bit
begin
  u: component baudRate2 generic map(BAUD_RATE   => BAUD_RATE,
                                     N           => N)
                         port    map(clk_i       => clk_i,
                                     rst_i       => rst_i,       
                                     pulsoNxBR_o => pulsoN);                                                                                                          
  rx: 
  process (pulsoN, rst_i) begin                      -- reset asincronico
    if rst_i='1' then
       registroRx <= (others => '0');
       bufferRx   <= (others => '0');
       proximoRx  <= idle;
    elsif rising_edge(pulsoN) then    
              
        case proximoRx is
        
          when idle =>  
             contadorBits    <= (others => '0');
             contadorPulsos  <= (others => '0');
             registroRx      <= (others => '0');            
             if rxd_i='0' then            
                proximoRx <= validando_start;            
             end if;                                    	

          when validando_start => 
             if contadorPulsos<(CANTIDAD_PULSOS/2) then   -- se posiciona en la mitad del bit
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
  end process rx; 
  
  caracter_o <= bufferRx;

end architecture Arq;
--------------------------------------------------------------------------------------------------------------
