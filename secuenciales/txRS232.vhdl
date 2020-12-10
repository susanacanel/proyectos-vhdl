-- 02.12.20 -------------------- Susana Canel ---------------------- txRS232.vhdl 
-- TRASMISOR DE LA UART (Universal Asynchronous Receiver/ Transmitter) RS_232.
-- TRANSMITE CARACTERES DE 8 BITS, CON UN SOLO BIT DE STOP Y SIN BIT DE PARIDAD.

library ieee;   
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.miPackage.all;
---------------------------------------------------------------------------------
entity txRS232 is
  generic(BITS       : positive := 8);
  port   (clk_i      : in  std_logic;
          rst_i      : in  std_logic; 
          dat_i      : in  std_logic_vector(BITS-1 downto 0);
          enviando_i : in  std_logic;
          dat_o      : out std_logic);   
end entity txRS232;
---------------------------------------------------------------------------------
architecture Arq of txRS232 is
  type     estado is (idle, start, enviando_datos, stop);
  signal   proximo   : estado;
  signal   pulso     : std_logic;
  signal   registro  : std_logic_vector(BITS-1 downto 0);
  signal   contador  : unsigned(3 downto 0);           
begin
  dut: component baudRate port map(clk_i   => clk_i,
                                   rst_i   => rst_i,
                                   pulso_o => pulso);                                                                                                        
  tx: 
  process (pulso) begin
    if rising_edge(pulso) then
      if rst_i='1' then
        proximo  <= idle;
        contador <= (others => '0');
        registro <= (others => '0');
        dat_o    <= '1';
      else  
        case proximo is
          when idle =>      
            if enviando_i='1' then
              registro <= dat_i;
              dat_o    <= '1';
              proximo  <= start;
            end if;
            
          when start =>
              dat_o    <= '0';
              contador <= (others => '0');
              proximo  <= enviando_datos;          
            
          when enviando_datos =>
              contador <= contador + 1;
              dat_o    <= registro(0);
              registro <= registro(0) & registro(BITS-1 downto 1);
              if contador=BITS-1 then
                proximo <= stop;
              end if;  
            
          when stop =>
              dat_o   <= '1';            
              proximo <= idle; 
    
        end case;    
      end if;
    end if;
  end process tx; 

end architecture Arq;
---------------------------------------------------------------------------------
