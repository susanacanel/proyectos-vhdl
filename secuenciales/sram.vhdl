-- 09.11.20 ---------------------- Susana Canel -------------------------- sram.vhdl
-- DESCRIPCION DE UNA MEMORIA RAM ESTATICA, DUAL PORT.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------------------
entity sram is
  generic(DIREC : positive := 3; 	   -- 3 lineas direccionan, 2^3=8 palabras
          BITS  : positive := 3);      -- 3 bits por palabra
  port   (clk_i : in  std_logic;
		  dir_i : in  std_logic_vector(DIREC-1 downto 0);
	      oe_i  : in  std_logic;
	      we_i  : in  std_logic;	
	      ce_i  : in  std_logic;
	      dat_i : in  std_logic_vector(BITS-1 downto 0);
		  dat_o : out std_logic_vector(BITS-1 downto 0));
end entity sram;

------------------------------------------------------------------------------------
-- SI NO ESTA HABILITADA PONE LA SALIDA EN ALTA IMPEDANCIA. 

architecture Arq of sram is
  type   memoria  is array (0 to (2**DIREC)-1) of std_logic_vector(BITS-1 downto 0);
  signal ram: memoria;						              										   	
begin
  process (clk_i) is begin
    if rising_edge(clk_i) then
      if we_i='1' and ce_i='1' then
        ram(to_integer(unsigned(dir_i))) <= dat_i;
        
      elsif oe_i='1' and ce_i='1' then
        dat_o <= ram(to_integer(unsigned(dir_i)));
        
      else
	    dat_o <= (others=>'Z'); 
	  end if;  
	  
    end if;              
  end process;                       
end architecture Arq;
------------------------------------------------------------------------------------
