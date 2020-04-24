-- 06.05.19 ----------- Susana Canel ---------- LatchD_tb.vhdl
-- TESTBENCH DEL LATCH D
library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------
entity LatchD_tb is
end entity LatchD_tb;
--------------------------------------------------------------
architecture Test of LatchD_tb is 
   -----------------------------
   component LatchD is
      port(d_i   : in  std_logic;
           le_i  : in  std_logic;
           q_o   : out std_logic);
   end component LatchD;
   --------------------------------
   signal d_t  : std_logic := '0';
   signal le_t : std_logic := '0';
   signal q_t  : std_logic;
begin
dut : LatchD port map(d_i  => d_t,
		      le_i => le_t,
	              q_o  => q_t);
Prueba:
   process begin
      report "Verificando el latch D"
      severity note;

      -- Modelizo la señal de entrada de manera que:
      -- cambie un tiempo tsu (set-up) antes que cambie LE y 
      -- que se mantenga un tiempo th (hold) despues del  
      -- cambio de LE. Al esperar que se propague LE ya se  
      -- cumple con el tiempo de hold. Sumo un tiempo extra 
      -- para que D tenga un tw (width) ancho de pulso min=8ns

      d_t  <= '0'; 
      wait for 2 ns; -- tsu
      le_t <= '1'; -------------------------------- Habilitado
      wait for 1 ns; 
      assert q_t='0'
         report "Falla para le=1, d=0"
         severity failure;

      wait for 5 ns; -- tw (2+1+5)ns = 8ns
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=1, d=1"
         severity failure;
        
      wait for 7 ns; -- tw (1+7)ns = 8ns
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=1, d=1"
         severity failure;	

      wait for 7 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=1, d=0"
         severity failure;

      wait for 7 ns;
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=1, d=1"
         severity failure;	

      d_t  <= '1'; 
      wait for 2 ns; -- tsu 
      le_t <= '0'; ------------------------------ Inhabilitado
      wait for 1 ns;  
      assert q_t='1'
         report "Falla para le=0, d=1"
         severity failure;

      wait for 5 ns; -- tw (2+1+5)ns = 8ns
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=0, d=0"
         severity failure;	

      wait for 7 ns; -- tw (1+7)ns = 8ns
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=0, d=1"
         severity failure;

      wait for 7 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=0, d=0"
         severity failure;

      wait for 7 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=0, d=0"
         severity failure;

      wait for 7 ns; -- tw (1+7)ns = 8ns
      d_t  <= '0'; 
      wait for 2 ns;  -- tsu
      le_t <= '1'; -------------------------------- Habilitado
      wait for 1 ns;   
      assert q_t='0'
         report "Falla para le=1, d=0"
         severity failure;

      wait for 5 ns;
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=1, d=1"
         severity failure;

      wait for 7 ns;
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para le=1, d=1"
         severity failure;

      wait for 7 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=1, d=0"
         severity failure;

      wait for 7 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=1, d=0"
         severity failure;

      wait for 7 ns; -- tw (1+7)ns = 8ns
      d_t  <= '0'; 
      wait for 2 ns;  -- tsu 
      le_t <= '0'; ------------------------------ Inhabilitado
      wait for 1 ns;  
      assert q_t='0'
         report "Falla para le=0, d=0"
         severity failure;
     
      wait for 5 ns; -- tw (2+1+5)ns = 8ns
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=0, d=1"
         severity failure;	

      wait for 7 ns; -- tw (1+7)ns = 8ns
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=0, d=1"
         severity failure;

      wait for 7 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=0, d=0"
         severity failure;

      wait for 7 ns;
      d_t  <= '1';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=0, d=1"
         severity failure;

      wait for 7 ns; -- tw (1+7)ns = 8ns
      d_t  <= '1'; 
      wait for 2 ns;  -- tsu
      le_t <= '1'; -------------------------------- Habilitado
      wait for 1 ns;   
      assert q_t='1'
         report "Falla para le=1, d=1"
         severity failure;

      wait for 5 ns;
      d_t  <= '0';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para le=1, d=0"
         severity failure;
  		  
      report "¡Verificación exitosa!"
      severity note;
      wait;
   end process Prueba;                      				
end architecture Test;
--------------------------------------------------------------

