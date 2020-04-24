-- 18.10.18 -------------------------- Susana Canel ---------------------------- Deco3a8_tb.vhdl
-- TESTBENCH PARA EL DECODIFICADOR de 3 A 8 BITS CON 
-- HABILITACION ACTIVA EN ALTO
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
-------------------------------------------------------------------------------------------------
entity Deco3a8_tb is
end entity Deco3a8_tb;
-------------------------------------------------------------------------------------------------
architecture Test of Deco3a8_tb is 
	--------------------------------------------------------
	component Deco3a8 is
		port(a_i   : in  std_logic_vector(2 downto 0);
		     ena_i : in  std_logic;
		     y_o   : out std_logic_vector(7 downto 0));
	end component Deco3a8;
	-------------------------------------------------------
	signal a_t   : std_logic_vector(2 downto 0) := "000";
	signal ena_t : std_logic := '1';
	signal y_t   : std_logic_vector(7 downto 0); 
begin 
dut: Deco3a8 port map(a_i   => a_t, 
		      ena_i => ena_t,
		      y_o   => y_t);  
Prueba:
	process begin
		report "Verificando el decodificador 3 a 8"
			severity note;
	
		ena_t <= '0';
		a_t   <= "100";
		wait for 1 ns;
		assert y_t = "00000000"
			report "Activa la salida 4 cuando ena=0"
			severity failure;
         
		ena_t <= '1';
		a_t   <= "011";
		wait for 1 ns;
		assert y_t = "00001000"
			report "No activa la salida 3 cuando ena=1"
			severity failure;	

		ena_t <= '0';
		a_t   <= "110"; 
		wait for 1 ns;
		assert y_t = "00000000"
			report "Activa la salida 6 con ena=0"
			severity failure;		
				
		ena_t <= '1';
		a_t   <= "111";  
		wait for 1 ns;
		assert y_t = "10000000"
			report "No activa la salida 7 con ena=1"
				severity failure;	
	
		ena_t <= '1';
		a_t   <= "101"; 
		wait for 1 ns;
		assert y_t = "00100000"
			report "No activa la salida 5 con ena=1"
			severity failure;	
		
		ena_t <= '1';
		a_t   <= "000"; 
		wait for 1 ns;
		assert y_t = "00000001"
			report "No activa la salida 0 con ena=1"
			severity failure;
		
		ena_t <= '1';
		a_t <= "010"; 
		wait for 1 ns;
		assert y_t = "00000100"
			report "No activa la salida 2 con ena=1"
			severity failure;	
		
		ena_t <= '1';
		for i in 0 to 7 loop
			a_t <= std_logic_vector(to_unsigned(i,3));
			wait for 1 ns;
			assert to_integer(unsigned(y_t)) = 2**i
				report "No activa la salida " & integer'image(i) & " con ena=1"
				severity failure;
		end loop;

		ena_t <= '0';
		for i in 0 to 7 loop
			a_t <= std_logic_vector(to_unsigned(i,3));
			wait for 1 ns;
			assert to_integer(unsigned(y_t)) = 0
				report "No activa la salida " & integer'image(i) & " con ena=0"
				severity failure;
		end loop;

		report "!Verificacion exitosa!"
		severity note;
		wait;
	end process Prueba;										
end architecture Test;
-------------------------------------------------------------------------------------------------



