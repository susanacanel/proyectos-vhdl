-- 21.07.16 -------- Susana Canel ------- CompAND2_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------
entity CompAND2_tb is
end entity CompAND2_tb;
----------------------------------------------------------
architecture Test of CompAND2_tb is
    -----------------------------------  
    component AND2_with_select is
 	    port(a_i, b_i  : in  std_logic;
		      y_o       : out std_logic);
    end component AND2_with_select;
    -----------------------------------
 	 signal a_t : std_logic := '0';
 	 signal b_t : std_logic := '0';
	 signal y_t	: std_logic;
begin
dut: AND2_with_select port map(a_i => a_t,
                               b_i => b_t,
                               y_o => y_t);
Prueba:
    process begin
      report "Verificando la compuerta AND de 2 entradas"
      severity note;
      
      a_t <= '0';
      b_t <= '0';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='0' y b_i='0'"
        severity warning;
        
      a_t <= '0';
      b_t <= '1';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='0' y b_i='1'"
        severity warning;   
        
      a_t <= '1';
      b_t <= '0';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='1' y b_i='0'"
        severity warning;  
        
      a_t <= '1';
      b_t <= '1';
      wait for 1 ns;
      assert y_t='1'
        report "Falla para a_i='1' y b_i='1'"
        severity warning;                 
           
	   a_t <= '0';
      b_t <= '1';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='0' y b_i='1'"
        severity warning;   
        
      a_t <= '1';
      b_t <= '0';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='1' y b_i='0'"
        severity warning;  
      
      a_t <= '0';
      b_t <= '0';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='0' y b_i='0'"
        severity warning;
		  
	   a_t <= '0';
      b_t <= '1';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='0' y b_i='1'"
        severity warning;   
		
      a_t <= '1';
      b_t <= '1';
      wait for 1 ns;
      assert y_t='1'
        report "Falla para a_i='1' y b_i='1'"
        severity warning;      
      
      a_t <= '0';
      b_t <= '0';
      wait for 1 ns;
      assert y_t='0'
        report "Falla para a_i='0' y b_i='0'"
        severity warning;
		  		  
      report "¡Verificación exitosa!"
      severity note;
      wait;
    end process Prueba;                      
		 
end architecture Test;
---------------------------------------------------------