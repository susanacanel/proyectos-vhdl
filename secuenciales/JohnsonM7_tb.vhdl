-- 23.04.20 --------------- Susana Canel ---------------- JohnsonM7_tb.vhdl
-- TESTBENCH DEL CONTADOR JOHNSON MODULO IMPAR.

library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------------
entity Johnson_tb is
end entity Johnson_tb;
---------------------------------------------------------------------------
architecture Test of Johnson_tb is
   ------------------------------------------------------
   component Johnson is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic; 
           rst_i : in  std_logic; 					 
           q_o   : out std_logic_vector(N-1 downto 0));
   end component Johnson;
   ------------------------------------------------------
   signal   clk_t      : std_logic :='1';
   signal   rst_t      : std_logic :='1';
   signal   q_t        : std_logic_vector(3 downto 0);
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns
   signal   detener    : boolean   := false;	 	
begin
   dut: Johnson generic map(N     => 4)
                port    map(clk_i => clk_t,
                            rst_i => rst_t,
                            q_o   => q_t);
   -------------------------------------
   GeneraReloj:						  
   process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
         wait;
      end if;
   end process GeneraReloj;
   -------------------------------------
   rst_t <= '1', '0' after PERIODO*3/2, '1' after 275 ns, '0' after 295 ns;

   Prueba: 		 
   process begin
      report "Verificando contador Johnson de 4 bits, modulo 7, arranque automatico."
      severity note;
		
      wait until rst_t='0';  
      wait for 5 ns;			   -- genera ts
      wait until rising_edge(clk_t);
      wait for 2 ns;		           -- espera tp  		           
      assert q_t="1000"
         report "Falla q para q=1000" 
         severity failure;
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1100"
         report "Falla q para q=1100" 
         severity failure;
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1110"
         report "Falla q para q=1110" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0111"
         report "Falla q para q=0111" 
         severity failure;
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0011"
         report "Falla q para q=0011" 
         severity failure;

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0001"
         report "Falla q para q=0001" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0000"
         report "Falla q para q=0000" 
         severity failure;
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1000"
         report "Falla q para si=1, q=1000" 
         severity failure;
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1100"
         report "Falla q para q=1100" 
         severity failure;
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1110"
         report "Falla q para q=1110" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0111"
         report "Falla q para q=0111" 
         severity failure;
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0011"
         report "Falla q para q=0011" 
         severity failure;
-------------------------------------------------------------- activa reset
      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="0000"
         report "Falla q para q=0000" 
         severity failure;
------------------------------------------------------------ inactiva reset
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1000"
         report "Falla q para q=1000" 
         severity failure;
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="1100"
         report "Falla q para si=1, q=1100" 
         severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba; 
                     								  
end architecture Test;
----------------------------------------------------------------
 