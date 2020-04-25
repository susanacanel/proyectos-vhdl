-- 21.09.19 ---------- Susana Canel ----------- contmpot2bidir_tb.vhdl
-- TESTBENCHS DEL CONTADOR SINCRONICO BINARIO, BIDIRECCIONAL, 
-- 3 BITS, MODULO M=8, HABILITACION ACTIVA EN ALTO, RESET SINC.

library ieee;  
use ieee.std_logic_1164.all;
----------------------------------------------------------------------
entity contmpot2bidir_tb is
end entity contmpot2bidir_tb;
----------------------------------------------------------------------
architecture Test of contmpot2bidir_tb is
   ----------------------------------------------------
   component contmpot2bidir is
      generic(N  : positive := 4);
      port(clk_i : in  std_logic;
           rst_i : in  std_logic;
           ena_i : in  std_logic;
           up_i  : in  std_logic;                
           q_o   : out std_logic_vector(N-1 downto 0));
   end component contmpot2bidir;
   ----------------------------------------------------
   signal clk_t : std_logic := '1';
   signal rst_t : std_logic := '1';
   signal ena_t : std_logic := '1';
   signal up_t  : std_logic := '1';
   signal q_t   : std_logic_vector(2 downto 0);
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns=20
   signal   detener    : boolean   := false;  
begin
   dut: contmpot2bidir generic map(N     => 3)
                       port    map(clk_i => clk_t,
                                   rst_i => rst_t,
                                   ena_i => ena_t,
                                   up_i  => up_t,
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
 
   rst_t <= '1', '0' after PERIODO*3/2;
 
   Prueba:
   process begin
      report "Verificando: contador bidireccional, hab., M=8"
      severity note;  
    
      wait until rst_t='0';  
      ----------------------------------------------------- habilitado
      ----------------------------------------------------- ascendente	 
      ena_t <= '1';                           
      up_t  <= '1';                           
      wait for 3 ns;                 ------- genera ts  y  propagacion
      wait until rising_edge(clk_t); ------- 1, el 0 lleg� en el reset 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 2 
      wait for 3 ns;
      assert q_t="010"
         report "Error para q=010, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 3 
      wait for 3 ns;
      assert q_t="011"
         report "Error para q=011, up=1"
         severity failure;	 
		 
      wait until rising_edge(clk_t); ------- 4
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100, up=1"
         severity failure;
      ---------------------------------------------------- descendente		 
      up_t  <= '0';                              
      wait for 3 ns; 		 
      wait until rising_edge(clk_t); ------- 3
      wait for 3 ns;
      assert q_t="011"
         report "Error para q=011, up=0"
         severity failure; 
		 
      wait until rising_edge(clk_t); ------- 2
      wait for 3 ns;
      assert q_t="010"
         report "Error para q=010, up=0"
         severity failure;	
		 
      wait until rising_edge(clk_t); ------- 1 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001"
         severity failure;	   
	 
      wait until rising_edge(clk_t); ------- 0   
      wait for 3 ns;
      assert q_t="000"
         report "Error para q=000, up=0"
         severity failure;  
		 
      wait until rising_edge(clk_t); ------- 7 
      wait for 3 ns;
      assert q_t="111"
         report "Error para q=111, up=0"
         severity failure;
      ----------------------------------------------------- ascendente		 
      up_t  <= '1';                                
      wait for 3 ns; 		 
      wait until rising_edge(clk_t); ------- 0
      wait for 3 ns;
      assert q_t="000"
         report "Error para q=000, up=1"
         severity failure;
  
      wait until rising_edge(clk_t); ------- 1   
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001, up=1"
         severity failure;  
      --------------------------------------------------- inhabilitado          
      ena_t <= '0';                                  
      wait for 3 ns;
      wait until rising_edge(clk_t); ------- 1 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001, ena=0"
         severity failure;
         	 
      wait until rising_edge(clk_t); ------- 1 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001, ena=0"
         severity failure;
      ----------------------------------------------------- habilitado          
      ena_t <= '1'; 
      wait for 3 ns;                                         	 
      wait until rising_edge(clk_t); ------- 2  
      wait for 3 ns;
      assert q_t="010"
         report "Error para q=010, up=1"
         severity failure;

      wait until rising_edge(clk_t); ------- 3
      wait for 3 ns;
      assert q_t="011"
         report "Error para q=011, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 4
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 5
      wait for 3 ns;
      assert q_t="101"
         report "Error para q=101, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 6
      wait for 3 ns;
      assert q_t="110"
         report "Error para q=110, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 7
      wait for 3 ns;
      assert q_t="111"
         report "Error para q=111, up=1"
         severity failure;
		 
      wait until rising_edge(clk_t); ------- 0
      wait for 3 ns;
      assert q_t="000"
         report "Error para q=000, up=1"
         severity failure;
      ---------------------------------------------------- descendente		 
      up_t  <= '0';                              
      wait for 3 ns; 		          	 
      wait until rising_edge(clk_t); ------- 7 		 
      wait for 3 ns;
      assert q_t="111"
         report "Error para q=111, up=0"
         severity failure;

      wait until rising_edge(clk_t); ------- 6 		 
      wait for 3 ns;
      assert q_t="110"
         report "Error para q=110, up=0"
         severity failure;

      wait until rising_edge(clk_t); ------- 5 		 
      wait for 3 ns;
      assert q_t="101"
         report "Error para q=101, up=0"
         severity failure;                   	                          	           
    
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;		
   end process Prueba;   
end architecture Test;
----------------------------------------------------------------------