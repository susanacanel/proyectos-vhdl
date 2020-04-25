-- 12.03.20 ---------------- Susana Canel -------------- ContAnillo_tb.vhdl
-- TESTBENCH DEL CONTADOR EN ANILLO CON ARRANQUE AUTOMATICO.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------------
entity ContAnillo_tb is
end entity ContAnillo_tb;
---------------------------------------------------------------------------
architecture Test of ContAnillo_tb is
   ------------------------------------------------------
   component ContAnillo is
   generic(N     : positive := 6);
   port   (clk_i : in  std_logic; 
           rst_i : in  std_logic; 					 
           q_o   : out std_logic_vector(N-1 downto 0)); 
   end component ContAnillo;
   ------------------------------------------------------
   signal   clk_t      : std_logic :='1';
   signal   rst_t      : std_logic :='1';
   signal   q_t        : std_logic_vector(5 downto 0);
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns
   signal   detener    : boolean   := false;	 	
begin
   dut: ContAnillo generic map(N     => 6)
                   port    map(clk_i => clk_t,
                               rst_i => rst_t,
                               q_o   => q_t);  
   -- GeneraReloj ----------------------					  
   process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
         wait;
      end if;
   end process;
   -------------------------------------
   rst_t <= '1', '0' after PERIODO*3/2, '1' after 197 ns, '0' after 217 ns;

   Prueba: 		 
   process begin
      report "Verificando contador en anillo arranque automatico, de 6 bits"
      severity note;
		
      wait until rst_t='0';  
      wait for 5 ns;			   -- genera ts
      wait until rising_edge(clk_t);
      wait for 2 ns;		           -- espera tp  	           		           
      assert q_t="010000"
         report "Falla q para q=010000" 
         severity failure;

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="001000"
         report "Falla q para q=001000" 
         severity failure;

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;	
      assert q_t="000100"
         report "Falla q para rst=1, q=000100" 
         severity failure;

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="000010"
         report "Falla q para q=000010" 
         severity failure;
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="000001"
         report "Falla q para q=000001" 
         severity failure;
	
      wait for 5 ns;			   
      wait until rising_edge(clk_t);
      wait for 2 ns;		             		           
      assert q_t="100000"
         report "Falla q para q=100000" 
         severity failure;
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="010000"
         report "Falla q para q=010000" 
         severity failure;

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="001000"
         report "Falla q para q=001000" 
         severity failure;
----------------------------------------------------------- se activa reset
      wait for 5 ns;			   
      wait until rising_edge(clk_t);
      wait for 2 ns;		             	           		           
      assert q_t="100000"
         report "Falla q para q=100000" 
         severity failure;
--------------------------------------------------------- se inactiva reset
      wait for 5 ns;			   
      wait until rising_edge(clk_t);
      wait for 2 ns;		             	           		           
      assert q_t="010000"
         report "Falla q para q=010000" 
         severity failure;

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="001000"
         report "Falla q para q=001000" 
         severity failure;

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;	
      assert q_t="000100"
         report "Falla q para rst=1, q=000100" 
         severity failure;

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="000010"
         report "Falla q para q=000010" 
         severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba; 
                     								  
end architecture Test;
---------------------------------------------------------------------------

 