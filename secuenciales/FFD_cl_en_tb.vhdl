-- 27.05.19 ---------- Susana Canel --------- FFD_cl_en_tb.vhdl  
-- TESTBENCH DEL FLIP-FLOP D, DISPARADO POR FLANCO POSITIVO,
-- CLEAR ASINCRONICO Y HABILITACION DEL RELOJ.

library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------
entity FFD_cl_en_tb is
end entity FFD_cl_en_tb;
--------------------------------------------------------------
architecture Test of FFD_cl_en_tb is 
   -------------------------------
   component FFD_cl_en is
      port(d_i    : in  std_logic;
           clk_i  : in  std_logic; 
           cl_i   : in  std_logic;
           en_i   : in  std_logic; 
           q_o    : out std_logic);
   end component FFD_cl_en;
   --------------------------------
   signal d_t   : std_logic := '0';
   signal clk_t : std_logic := '0';
   signal cl_t  : std_logic := '0';
   signal en_t  : std_logic := '0';
   signal q_t   : std_logic;
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns 20
   signal detener      : boolean := false;
	
begin
dut : FFD_cl_en port map(d_i   => d_t,
                         clk_i => clk_t, 
                         cl_i  => cl_t,
                         en_i  => en_t,
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
      report "Verificando el ff D con Clear y Habilitacion"
      severity note;
      ---------------------------------------- clear activo	
      ---------------------------------------- clock habilitado		
      cl_t <= '1';
      en_t <= '1';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='0'
         report "Falla para cl=1, en=1, d=1" 
         severity failure; 		
      ---------------------------------------- clear inactivo
      ---------------------------------------- clock habilitado      
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;
			
      wait for 10 ns; 
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '0';
      wait for 5 ns;
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t='0'
         report "Falla para cl=0, en=1, d=0" 
	 severity failure;
			
      wait for 10 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;			
      ---------------------------------------- clear activo			
      wait for 10 ns;
      cl_t <= '1';
      en_t <= '1';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='0'
         report "Falla para cl=1, en=1, d=1" 
         severity failure; 		
      ---------------------------------------- clear inactivo
      ---------------------------------------- clock inhabilitado	
      wait for 10 ns;
      cl_t <= '0';
      en_t <= '0';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=0, d=1" 
         severity failure;
      ---------------------------------------- clear inactivo	
      ---------------------------------------- clock habilitado		
      wait for 10 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;
      ---------------------------------------- clear activo	
      ---------------------------------------- clock inhabilitado		
      wait for 10 ns;			
      cl_t <= '1';
      en_t <= '0';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='0'
         report "Falla para cl=1, en=0, d=1" 
         severity failure;
      --------------------------------------- clear inactivo	
      --------------------------------------- clock inhabilitado		
      wait for 10 ns;			
      cl_t <= '0';
      en_t <= '0';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=0, d=1" 
         severity failure;
      ---------------------------------------- clear inactivo	
      ---------------------------------------- clock habilitado			
      wait for 10 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;
			
      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '0';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=1, d=0" 
         severity failure;
			
      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '0';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=1, d=0" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '0';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=1, d=0" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '0';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=1, d=0" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '1';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='1'
         report "Falla para cl=0, en=1, d=1" 
         severity failure;

      wait for 1 ns;			
      cl_t <= '0';
      en_t <= '1';
      d_t  <= '0';
      wait for 1 ns;		
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      assert q_t='0'
         report "Falla para cl=0, en=1, d=0" 
         severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;                      	
end architecture Test;
---------------------------------------------------------------
