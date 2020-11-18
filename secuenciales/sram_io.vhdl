-- 13.11.20 -------------------- Susana Canel ------------------------- sram_io.vhdl
-- DESCRIPCION DE UNA MEMORIA RAM ESTATICA SINCRONICA, CON BUS BIDIRECCIONAL.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------------------
entity sram_io is
  generic(DIREC  : positive := 4; 	    -- 4 lineas direccionan, 2^4=16 palabras
          BITS   : positive := 4);      -- 4 bits por palabra
  port   (clk_i  : in    std_logic;
		  dir_i  : in    std_logic_vector(DIREC-1 downto 0);
	      oe_i   : in    std_logic;
	      we_i   : in    std_logic;	
	      cs_i   : in    std_logic;
	      dat_io : inout std_logic_vector(BITS-1 downto 0));
end entity sram_io;

------------------------------------------------------------------------------------
-- SI NO ESTA HABILITADA PONE EL BUS DE DATOS EN ALTA IMPEDANCIA. 

architecture Arq of sram_io is
  type   memoria is array (0 to (2**DIREC)-1) of std_logic_vector(BITS-1 downto 0);
  signal ram: memoria;						              										   	
begin

  process (clk_i) is begin
    if rising_edge(clk_i) then
      if we_i='1' and cs_i='1' then
        ram(to_integer(unsigned(dir_i))) <= dat_io;
        
      elsif oe_i='1' and cs_i='1' then
        dat_io <= ram(to_integer(unsigned(dir_i)));
        
      else
	    dat_io <= (others=>'Z'); 
	    
	  end if;  
    end if;              
  end process;
  	                              
end architecture Arq;
------------------------------------------------------------------------------------
