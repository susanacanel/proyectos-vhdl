-- 13.11.20 ---------------------- Susana Canel ----------------------- sram_io_leds.vhdl 
-- SRAM CON BUS BIDIRECCIONAL PARA LA PLAQUETA.
library ieee;   
use ieee.std_logic_1164.all;
use work.miPackage.all;
-----------------------------------------------------------------------------------------
entity sram_io_leds is
   generic(DIR        : positive := 3;          -- 3 lineas de direciones, 2^3=8 palabras
           BITS       : positive := 3);         -- 3 bits de datos
   port   (clk_i      : in  std_logic;
           dir_i      : in  std_logic_vector(DIR-1 downto 0);
           ceRam_i    : in  std_logic;
           oeRam_i    : in  std_logic;
           weRam_i    : in  std_logic;
           dato_i     : in  std_logic_vector(BITS-1 downto 0);
           leds_o     : out std_logic_vector(BITS-1 downto 0);
           ledsBus_o  : out std_logic_vector(BITS-1 downto 0));
end entity sram_io_leds;
-----------------------------------------------------------------------------------------
architecture Arq of sram_io_leds is
  signal busDato   : std_logic_vector(BITS-1 downto 0);  
begin
  u1: component sram_io generic map(DIREC  => DIR,
                                    BITS   => BITS)
                        port    map(clk_i  => clk_i,
                                    dir_i  => dir_i ,
                                    oe_i   => oeRam_i,
                                    we_i   => weRam_i,
                                    cs_i   => ceRam_i,
                                    dat_io => busDato);
                                         
  busDato   <= dato_i  when ceRam_i='1' and weRam_i='1' else
               (others=>'Z');
                        
  leds_o    <= busDato when ceRam_i='1' and oeRam_i='1' else
               (others=>'Z');
            
  ledsBus_o <= busDato;           

end architecture Arq;
-----------------------------------------------------------------------------------------
