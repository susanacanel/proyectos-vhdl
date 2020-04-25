-- 15.08.19 ---------- Susana Canel --------- FFJK_cl_ps_tb.vhdl  
-- TESTBENCH DEL FLIP-FLOP JK, DISPARADO POR FLANCO POSITIVO,
-- CLEAR Y PRESET ASINCRONICOS.

library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------
entity FFJK_cl_ps_tb is
end entity FFJK_cl_ps_tb;
--------------------------------------------------------------
architecture Test of FFJK_cl_ps_tb is 
   -------------------------------
   component FFJK_cl_ps is
   port(j_i    : in  std_logic;
        k_i    : in  std_logic;
        clk_i  : in  std_logic; 
        cl_i   : in  std_logic;
        ps_i   : in  std_logic; 
        q_o    : out std_logic);
   end component FFJK_cl_ps;
   --------------------------------
   signal j_t          : std_logic := '0';
   signal k_t          : std_logic := '0';
   signal clk_t        : std_logic := '0';
   signal cl_t         : std_logic := '0';
   signal ps_t         : std_logic := '0';
   signal q_t          : std_logic;
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
   signal   detener    : boolean := false;
	
begin
dut : FFJK_cl_ps port map(j_i   => j_t,
                          k_i   => k_t,
                          clk_i => clk_t, 
                          cl_i  => cl_t,
                          ps_i  => ps_t,
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
      report "Verificando el ff JK con Clear y preset"
      severity note;
      ----------------------------------------- clear inactivo
      ------------------------------------------ preset activo      
      cl_t <= '0';
      ps_t <= '1';
      j_t  <= '0';
      k_t  <= '1';
      wait for 4 ns;                             -- genera ts
      wait until rising_edge(clk_t);
      wait for 2 ns;		                 -- espera tp
      assert q_t='1'
         report "Falla para cl=0, ps=1, j=0, k=1" 
         severity failure;
      ------------------------------------------- clear activo	
      ---------------------------------------- preset inactivo		
      wait for 12 ns;                          
      cl_t <= '1';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '0';
      wait for 4 ns;
      wait until rising_edge(clk_t);
      wait for 2 ns;
      assert q_t='0'
         report "Falla para cl=1,  ps=0, j=1, k=0" 
         severity failure;
      ------------------------------- preset y clear inactivos	
      -------------------------------------------------- setea		
      wait for 12 ns;			
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para cl=0, ps=0, j=1, k=0" 
         severity failure;			
      ------------------------------------------------ resetea			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '0';
      k_t  <= '1';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para cl=0, ps=0, j=0, k=1" 
         severity failure;
     ------------------------------------------------ memoriza			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '0';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para cl=0, ps=0, j=0, k=0" 
         severity failure;
      -------------------------------------------- complementa			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '1';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para cl=0, ps=0, j=1, k=1" 
         severity failure;
      ------------------------------ preset y clear activos			
      wait for 12 ns; 
      cl_t <= '1';
      ps_t <= '1';
      j_t  <= '1';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;
      assert q_t='0'
         report "Falla para cl=1, ps=1, j=1, k=0" 
         severity failure;
      ------------------------------ preset y clear inactivos	
      ------------------------------------------- complementa		
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '1';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para cl=0, ps=0, j=1, k=1" 
         severity failure;
     ------------------------------------------------ memoriza			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '0';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para cl=0, ps=0, j=0, k=0" 
         severity failure;
     --------------------------------------------- complementa		
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '1';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para cl=0, ps=0, j=1, k=1" 
         severity failure;
     ------------------------------------------------ memoriza			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '0';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para cl=0, ps=0, j=0, k=0" 
         severity failure;
      -------------------------------------------------- setea		
      wait for 12 ns;			
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para cl=0, ps=0, j=1, k=0" 
         severity failure;
      -------------------------------------------------- setea		
      wait for 12 ns;			
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '1';
      k_t  <= '0';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para cl=0, ps=0, j=1, k=0" 
         severity failure;
      ------------------------------------------------ resetea			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '0';
      k_t  <= '1';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para cl=0, ps=0, j=0, k=1" 
         severity failure;
      ------------------------------------------------ resetea			
      wait for 12 ns;
      cl_t <= '0';
      ps_t <= '0';
      j_t  <= '0';
      k_t  <= '1';
      wait for 4 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para cl=0, ps=0, j=0, k=1" 
         severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;                      	
end architecture Test;
--------------------------------------------------------------