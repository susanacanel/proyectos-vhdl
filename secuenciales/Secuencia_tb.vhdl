-- 11.11.19 ---------------- Susana Canel --------------- Secuencia_tb.vhdl
-- TESTBENCH, GENERADOR DE SECUENCIA PSEUDO ALEATORIA, N=5
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------------
entity Secuencia_tb is
end entity Secuencia_tb;
---------------------------------------------------------------------------
architecture Test of Secuencia_tb is
   -------------------------------------------------------
   component Secuencia is
      generic(N     : positive:=5);
      port   (clk_i : in  std_logic;
              rst_i : in  std_logic;
              so_o  : out std_logic;
              q_o   : out std_logic_vector(N-1 downto 0));
   end component Secuencia;
   -------------------------------------------------------
   signal clk_t        : std_logic := '1';
   signal rst_t        : std_logic := '1';
   signal so_t         : std_logic;
   signal q_t          : std_logic_vector(4 downto 0);
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
   signal   detener    : boolean := false;	 	
begin
   dut: Secuencia generic map(N     => 5)
                  port    map(clk_i => clk_t,
                              rst_i => rst_t,
                              so_o  => so_t,
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
   rst_t <= '1', '0' after PERIODO*3/2, '1' after 716 ns, '0' after 736 ns;
		 
   Prueba:
   process begin
      report "Verificando generador de secuencia aleatoria"
      severity note;

      wait until rst_t='0';  	
      wait for 5 ns;                       -- espera ts		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           -- espera tp
      assert q_t="10000"
         report "Falla para 1, q=10000" 
         severity failure;
		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01000"
         report "Falla para 2, q=01000" 
         severity failure;
	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="00100"
         report "Falla para 3, q=00100" 
         severity failure;
		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10010"
         report "Falla para 4, q=10010" 
         severity failure;
	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01001"
         report "Falla para 5, q=01001" 
         severity failure;
		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10100"
         report "Falla para 6, q=10100" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11010"
         report "Falla para 7, q=11010" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01101"
         report "Falla para 8, q=01101" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="00110"
         report "Falla para 9, q=00110" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10011"
         report "Falla para 10, q=10011" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11001"
         report "Falla para 11, q=11001" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11100"
         report "Falla para 12, q=11100" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11110"
         report "Falla para 13, q=11110" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11111"
         report "Falla para 14, q=11111" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01111"
         report "Falla para 15, q=01111" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="00111"
         report "Falla para 16, q=00111" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="00011"
         report "Falla para 17, q=00011" 
         severity failure;

      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10001"
         report "Falla para 18, q=10001" 
         severity failure;

  	
      wait until rising_edge(clk_t);
  	
      wait until rising_edge(clk_t);
     		
      wait until rising_edge(clk_t);	
	
      wait until rising_edge(clk_t);	
		
      wait until rising_edge(clk_t);
		
      wait until rising_edge(clk_t);
		
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
	
      wait until rising_edge(clk_t);
																																																
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;   
                   								  
end architecture Test;
---------------------------------------------------------------------------
