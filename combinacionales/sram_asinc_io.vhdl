-- 26.11.20 ---------------------- Susana Canel ------------------------ sram_asinc_io.vhdl
-- DESCRIPCION DE UNA MEMORIA RAM ESTATICA ASINCRONICA CON BUS DE DATOS BIDIRECCIONAL.
-- ADVERTENCIA: NO SE RECOMIENDA UNA MEMORIA ASINCRONICA EN UNA FPGA.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------------------
entity sram_asinc_io is
  generic(DIREC  : positive := 4;                  -- 4 lineas direccionan, 2^4=16 palabras
          BITS   : positive := 4);                 -- 4 bits por palabra
  port   (dir_i  : in    std_logic_vector(DIREC-1 downto 0);
	      cs_i   : in    std_logic;
	      we_i   : in    std_logic;	
	      oe_i   : in    std_logic;
	      dat_io : inout std_logic_vector(BITS-1 downto 0));
end entity sram_asinc_io;

-------------------------------------------------------------------------------------------
-- SI NO ESTA HABILITADA PONE EL BUS DE DATOS EN ALTA IMPEDANCIA. 

architecture Arq of sram_asinc_io is
  type   memoria is array (0 to (2**DIREC)-1) of std_logic_vector(BITS-1 downto 0);
  signal sram: memoria;						              										   	
begin

  sram(to_integer(unsigned(dir_i))) <= dat_io when we_i='1' and cs_i='1' else
                                      (others => 'Z');
  
  dat_io <= sram(to_integer(unsigned(dir_i))) when oe_i='1' and cs_i='1' else
           (others => 'Z');

        
end architecture Arq;
-------------------------------------------------------------------------------------------

