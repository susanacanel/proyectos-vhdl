-- 26.08.19 ---------- Susana Canel ----------- ContMpot2Q_tb.vhdl
-- TESTBENCHS DEL CONTADOR SINCRONICO BINARIO, DE 3 BITS, MODULO 
-- POTENCIA DE DOS. SALIDA: CUENTA.

library ieee;  
use ieee.std_logic_1164.all;
------------------------------------------------------------------
entity ContMpot2Q_tb is
end entity ContMpot2Q_tb;
------------------------------------------------------------------
architecture Test of ContMpot2Q_tb is
   -------------------------------------------------------
   component ContMpot2Q is
      generic(N     : positive := 3);
      port   (clk_i : in  std_logic;
              q_o   : out std_logic_vector(N-1 downto 0));
   end component ContMpot2Q;
   -------------------------------------------------------
   signal   clk_t      : std_logic := '1';
   signal   q_t        : std_logic_vector(2 downto 0);  
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns:20
   signal   detener    : boolean   := false;  
begin
   dut: ContMpot2Q generic map(N     => 3)
                   port    map(clk_i => clk_t,
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
   Prueba:
   process begin
      report "Verificando el contador de 3 bits, estado, M=8"
      severity note;
 
      wait until rising_edge(clk_t); ------- 0   
      wait for 3 ns;
      assert q_t="000"
         report "Error para q=000"
         severity warning;

      wait until rising_edge(clk_t); ------- 1 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001"
         severity warning;
		 
      wait until rising_edge(clk_t); ------- 2 
      wait for 3 ns;
      assert q_t="010"
         report "Error para q=010"
         severity warning;
		 
      wait until rising_edge(clk_t); ------- 3 
      wait for 3 ns;
      assert q_t="011"
         report "Error para q=011"
         severity warning;	 
		 
      wait until rising_edge(clk_t); ------- 4
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100"
         severity warning;
		 
      wait until rising_edge(clk_t); ------- 5
      wait for 3 ns;
      assert q_t="101"
         report "Error para q=101"
         severity warning;  
		 
      wait until rising_edge(clk_t); ------- 6
      wait for 3 ns;
      assert q_t="110"
         report "Error para q=110"
         severity warning;	
		 
      wait until rising_edge(clk_t); ------- 7 
      wait for 3 ns;
      assert q_t="111"
         report "Error para q=111"
         severity warning;	   
	 
      wait until rising_edge(clk_t); ------- 0   
      wait for 3 ns;
      assert q_t="000"
         report "Error para q=000"
         severity warning;  
		 
      wait until rising_edge(clk_t); ------- 1 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001"
         severity warning;
		 
      wait until rising_edge(clk_t); ------- 2 
      wait for 3 ns;
      assert q_t="010"
         report "Error para q=010"
         severity warning;
		 
      wait until rising_edge(clk_t); ------- 3 
      wait for 3 ns;
      assert q_t="011"
         report "Error para q=011"
         severity warning;	 
		 
      wait until rising_edge(clk_t); ------- 4
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100"
         severity warning;
		 
      wait until rising_edge(clk_t); ------- 5
      wait for 3 ns;
      assert q_t="101"
         report "Error para q=101"
         severity warning;  
		 
      wait until rising_edge(clk_t); ------- 6
      wait for 3 ns;
      assert q_t="110"
         report "Error para q=110"
         severity warning;	
		 
      wait until rising_edge(clk_t); ------- 7 
      wait for 3 ns;
      assert q_t="111"
         report "Error para q=111"
         severity warning;	   
	 
      wait until rising_edge(clk_t); ------- 0   
      wait for 3 ns;
      assert q_t="000"
         report "Error para q=000"
         severity warning; 
       	               	                          	           
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;		
   end process Prueba;   
end architecture Test;
------------------------------------------------------------------
