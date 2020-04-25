-- 05.11.19 --------------- Susana Canel -------------- RegSISO_rst_tb.vhdl
-- TESTBENCH DEL REGISTRO REGISTRO SISO Y SIPO, CARGA PARALELO,    
-- DE 5 BITS, DE DESPLAZAMIENTO A DERECHA, CON RESET SINCRONICO.
library ieee;   
use ieee.std_logic_1164.all;
----------------------------------------------------------------------------
entity RegSISO_rst_tb is
end entity RegSISO_rst_tb;
----------------------------------------------------------------------------
architecture Test of RegSISO_rst_tb is
   ------------------------------------------------------
   component RegSISO_rst is
      generic(N     : positive := 4);
      port   (clk_i : in  std_logic;
              rst_i : in  std_logic;
              pe_i  : in  std_logic;
              si_i  : in  std_logic;
              d_i   : in  std_logic_vector(N-1 downto 0);
              q_o   : out std_logic_vector(N-1 downto 0);
              so_o  : out std_logic);
   end component RegSISO_rst;
   ------------------------------------------------------
   signal clk_t : std_logic :='1';
   signal rst_t : std_logic :='1';
   signal pe_t  : std_logic :='0';
   signal si_t  : std_logic :='0';
   signal d_t   : std_logic_vector(4 downto 0) := "00000";
   signal q_t   : std_logic_vector(4 downto 0);
   signal so_t  : std_logic;
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
   signal detener      : boolean := false;	 	
begin
   dut: RegSISO_rst generic map(N     => 5)
                    port    map(clk_i => clk_t,
                                rst_i => rst_t,
                                pe_i  => pe_t,
                                si_i  => si_t,
                                d_i   => d_t,
                                q_o   => q_t,
                                so_o  => so_t);
   -- GeneraReloj ----------------------						  
   process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
         wait;
      end if;
   end process;
   -------------------------------------
   rst_t <= '1', '0' after PERIODO*3/2, '1' after 238 ns, '0' after 258 ns;
 		 
    process begin
      report "Verificando reg. desplazamiento a derecha, 5 bits"
      severity note;
		
      si_t <= '1';
      wait until rst_t='0';  
      wait for 5 ns;			   -- genera ts
      wait until rising_edge(clk_t);
      wait for 2 ns;		           -- espera tp  
      assert q_t="10000"
         report "Falla q para si=1, q=10000" 
         severity failure;
      assert so_t='0'
         report "Falla so para si=1, q=10000, so=0" 
         severity failure;

      si_t <= '1';
      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11000"
         report "Falla q para si=1, q=11000" 
         severity failure;
      assert so_t='0'
         report "Falla so para si=1, q=11000, so=0" 
         severity failure;
		
      si_t <= '0';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01100"
         report "Falla q para si=1, q=01100" 
         severity failure;
      assert so_t='0'
         report "Falla so para si=1, q=01100, so=0" 
         severity failure;
	
      si_t <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10110"
         report "Falla q para si=1, q=10110" 
         severity failure;
      assert so_t='0'
         report "Falla so para si=1, q=10110, so=0" 
         severity failure;
		
      si_t <= '0';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01011"
         report "Falla q para si=0, q=01011" 
         severity failure;
      assert so_t='1'
         report "Falla so para si=1, q=01011, so=1" 
         severity failure;

      si_t <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10101"
         report "Falla q para si=1, q=10101" 
         severity failure;
      assert so_t='1'
         report "Falla so para si=1, q=10101, so=1" 
         severity failure;
		
      si_t <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11010"
         report "Falla q para si=1, q=11010" 
         severity failure;
      assert so_t='0'
         report "Falla so para si=1, q=11010, so=0" 
         severity failure;
	
      si_t <= '1';
      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11101"
         report "Falla q para si=1, q=11101" 
         severity failure;
      assert so_t='1'
         report "Falla so para si=1, q=11101, so=1" 
         severity failure;
	
      si_t <= '0';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01110"
         report "Falla q para si=0, q=01110" 
         severity failure;
      assert so_t='0'
         report "Falla so para si=0, q=01110, so=0" 
         severity failure;
	
      si_t <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10111"
         report "Falla q para si=1, q=10111" 
         severity failure;
      assert so_t='1'
         report "Falla so para si=1, q=10111, so=1" 
         severity failure;
      -------------------------------------------------------- reset activo
      si_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="00000"
         report "Falla q para rst=1, q=00000" 
         severity failure;
      assert so_t='0'
         report "Falla so para rst=1, q=00000, so=0" 
         severity failure;	
      ------------------------------------------------------ reset inactivo
      si_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="10000"
         report "Falla q para rst=0, si=1, q=10000" 
         severity failure;
      assert so_t='0'
         report "Falla so para rst=0, q=10000, so=0" 
         severity failure;
      ----------------------------------------------- carga paralelo activa
      pe_t <= '1';
      d_t  <= "11111";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="11111"
         report "Falla q para pe=1, q=11111" 
         severity failure;
      assert so_t='1'
         report "Falla so para pe=1, q=11111, so=1" 
         severity failure;
      --------------------------------------------- carga paralelo inactiva
      pe_t <= '0';
      si_t <= '0';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
      assert q_t="01111"
         report "Falla q para pe=0, si=0, q=01111" 
         severity failure;
      assert so_t='1'
         report "Falla so para pe=0, si=0, q=01111, so=1" 
         severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process; 
                     								  
end architecture Test;
---------------------------------------------------------------------------