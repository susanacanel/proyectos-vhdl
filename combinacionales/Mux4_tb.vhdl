-- 19.10.18 ------------------- Susana Canel --------------------- Mux4_tb.vhdl
-- TESTBENCH, MULTIPLEXOR DE 4 CANALES, 2 SELECCION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity Mux4_tb is
end entity Mux4_tb;

--------------------------------------------------------------------------------
architecture Test of Mux4_tb is 
   	-------------------------------------------------------
   	component Mux4 is
		port(i_i    : in  std_logic_vector(3 downto 0);
	     	     sel_i  : in  std_logic_vector(1 downto 0);
	     	     y_o    : out std_logic);
   	end component Mux4;
   	-------------------------------------------------------
	signal i_t   : std_logic_vector(3 downto 0) :="0000";
	signal sel_t : std_logic_vector(1 downto 0) :="00"; 
	signal y_t   : std_logic;
begin
dut: Mux4 port map(i_i   => i_t,
	     	   sel_i => sel_t,
	     	   y_o   => y_t);
Prueba:
   	process begin
      		report "Verificando el multiplexor de 4 entradas"
      		severity note;
		
		for j in 0 to 15 loop                      
      			i_t   <= std_logic_vector(to_unsigned(j,4));
			for i in 0 to 3 loop
				sel_t <= std_logic_vector(to_unsigned(i,2));
				wait for 1 ns;
				assert y_t=i_t(i)
					report "Falla para sel=" & integer'image(i) & " e i=" & integer'image(j)
					severity failure;
			end loop;
		end loop;                          
		  
      		report "¡Verificación exitosa!"
      		severity note;
      		wait;
    	end process Prueba;                      
end architecture Test;
----------------------------------------------------------------------------------------------------------------