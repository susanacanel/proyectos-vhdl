-- 28.07.16 ----------- Susana Canel ---------- RegDesN_tb.vhd
-- TESTBENCH DEL REG. DE DESPLAZAMIENTO A DERECHA, DE 5 BITS,  
-- ACTIVO POR FLANCO ASCENDENTE, CON RESET SINCRONICO
library ieee;   
use ieee.std_logic_1164.all;
--------------------------------------------------------------
entity RegDesN_tb is
end entity RegDesN_tb;
--------------------------------------------------------------
architecture Test of RegDesN_tb is
	----------------------------------------------------
	component RegDesN is
	   generic(N  : positive := 5);
	   port(clk_i : in  std_logic;
	        rst_i : in  std_logic;
		     si_i  : in  std_logic;
		     q_o	  : out std_logic_vector(N-1 downto 0));
   end component RegDesN;
	----------------------------------------------------
	signal clk_t : std_logic;
	signal rst_t : std_logic;
	signal si_t  : std_logic;
	signal q_t   : std_logic_vector(4 downto 0);
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
   signal detener 	  : boolean := false;	 	
begin
dut : RegDesN generic map(N  => 5)
              port map(clk_i => clk_t,
	                    rst_i => rst_t,
		                 si_i  => si_t,
		                 q_o	  => q_t);
	 ------------------------------------						  
GeneraReloj: process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
        wait;
      end if;
    end process GeneraReloj;
    ------------------------------------
    rst_t <= '1', '0' after PERIODO*3/2;
    ------------------------------------		 
Prueba:
    process begin
      report "Verificando reg. desplazamiento a derecha, 5 bits"
      severity note;
		
		si_t <= '1';
		wait for 5 ns;
		
      wait until rst_t='0';  
		wait for 5 ns;		
				
      wait until rising_edge(clk_t);
		wait for 5 ns;		           -- espera tp de un ff y th
 	   assert q_t="10000"
			report "Falla para si=1, q=10000" 
			severity warning;
		
		si_t <= '1';
		wait for 5 ns;	            -- genera ts	
      wait until rising_edge(clk_t);
		wait for 5 ns;		           
 	   assert q_t="11000"
			report "Falla para si=1, q=11000" 
			severity warning;
		
		si_t <= '0';
		wait for 5 ns;		
      wait until rising_edge(clk_t);
		wait for 5 ns;		           
 	   assert q_t="01100"
			report "Falla para si=1, q=01100" 
			severity warning;
		
		si_t <= '1';
		wait for 5 ns;		
      wait until rising_edge(clk_t);
		wait for 5 ns;		           
 	   assert q_t="10110"
			report "Falla para si=1, q=10110" 
			severity warning;
		
		si_t <= '0';
		wait for 5 ns;		
      wait until rising_edge(clk_t);
		wait for 5 ns;		           
 	   assert q_t="01011"
			report "Falla para si=1, q=01011" 
			severity warning;
		
		si_t <= '1';
		wait for 5 ns;		
      wait until rising_edge(clk_t);
		wait for 5 ns;		           
 	   assert q_t="10101"
			report "Falla para si=1, q=10101" 
			severity warning;
		
		si_t <= '1';
		wait for 5 ns;		
      wait until rising_edge(clk_t);
		wait for 5 ns;		           
 	   assert q_t="11010"
			report "Falla para si=1, q=11010" 
			severity warning;
			
			report "Verificacion exitosa!"
      severity note;
		detener <= true;
      wait;
    end process Prueba;                      								  
end architecture Test;
--------------------------------------------------------------