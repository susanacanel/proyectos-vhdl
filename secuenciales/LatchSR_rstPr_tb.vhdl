-- 09.05.19 ---------- Susana Canel --------- LatchSR_rstPr_tb.vhdl
-- TESTBENCH DEL LATCH SR CON RESET PRIORITARIO

library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------
entity LatchSR_rstPr_tb is
end entity LatchSR_rstPr_tb;
-------------------------------------------------------------------
architecture Test of LatchSR_rstPr_tb is 
   -----------------------------
   component LatchSR_rstPr is
      port(r_i : in  std_logic;
           s_i : in  std_logic;
           q_o : out std_logic);
   end component LatchSR_rstPr;
   --------------------------------
   signal r_t : std_logic := '0';
   signal s_t : std_logic := '0';
   signal q_t : std_logic;
begin
dut : LatchSR_rstPr port map(r_i => r_t,
		             s_i => s_t,
	                     q_o => q_t);
Prueba:
   process begin
      report "Verificando el latch SR con reset prioritario"
      severity note;
      
      s_t <= '1';  --------------------- activo solo SET     (setea)
      r_t <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para s=1, r=0"
         severity failure;
        
      s_t <= '0'; 
      r_t <= '1';  --------------------- activo solo RESET (resetea)  
      wait for 1 ns;
      assert q_t='0'
         report "Falla para s=0, r=1"
         severity failure; 
                
      s_t <= '1';  --------------------- ambos activos     (resetea)
      r_t <= '1';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para s=1, r=1"
         severity failure;
         
      s_t <= '0';  --------------------- ambos inactivos  (memoriza)
      r_t <= '0';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para s=0, r=0"
         severity failure;
        	        
      s_t <= '1';  --------------------- activo solo SET     (setea)
      r_t <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para s=1, r=0"
         severity failure;
                
      s_t <= '0';  --------------------- ambos inactivos  (memoriza) 
      r_t <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para s=0, r=0"
         severity failure;
                
      s_t <= '1';  --------------------- ambos activos     (resetea) 
      r_t <= '1';    
      wait for 1 ns;
      assert q_t='0'
         report "Falla para s=1, r=1"
         severity failure;   
                
      s_t <= '1';  --------------------- activo solo SET     (setea) 
      r_t <= '0';    
      wait for 1 ns;
      assert q_t='1'
         report "Falla para s=1, r=0"
         severity failure;   
		  		  
      report "Verificacion exitosa!"
      severity note;
      wait;
   end process Prueba;                      				
end architecture Test;
-------------------------------------------------------------------
