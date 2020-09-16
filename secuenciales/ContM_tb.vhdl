-- 16.09.20 ------------- Susana Canel --------------- ContM_tb.vhdl
-- TESTBENCHS DEL CONTADOR GENERICO, SINCRONICO, MODULO M, 
-- HABILITACION Y RESET. SALIDAS: ESTADO Y CUENTA TERMINAL.
-- TESTBENCH HECHO PARA UN CONTADOR DECIMAL, M=10.

library ieee;  
use ieee.std_logic_1164.all;
--------------------------------------------------------------------
entity ContM_tb is
end entity ContM_tb;
--------------------------------------------------------------------
architecture Test of ContM_tb is
   -----------------------------------------------------
   component ContM is
      generic(N   : positive := 4);
      port(clk_i  : in  std_logic;
           rst_i  : in  std_logic;
           ena_i  : in  std_logic;
           tc_o   : out std_logic;
           q_o    : out std_logic_vector(N-1 downto 0));
   end component ContM;
   -----------------------------------------------------
   signal   clk_t      : std_logic :='1';
   signal   rst_t      : std_logic :='1';
   signal   ena_t      : std_logic :='1';
   signal   tc_t       : std_logic;
   signal   q_t        : std_logic_vector(3 downto 0);  
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns=20
   signal   detener    : boolean   := false;    
begin
   dut: ContM generic map(N     => 4)
              port    map(clk_i => clk_t,
                          rst_i => rst_t,
                          ena_i => ena_t,
                          tc_o  => tc_t,
                          q_o   => q_t);
   ------------------------------------
   GeneraReloj:
   process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
         wait;
      end if;
   end process GeneraReloj;
   ------------------------------------

   rst_t <= '1', '0' after PERIODO*3/2, '1' after 543 ns, '0' after 573 ns;

   Prueba:
   process begin
      report "Verificando contador decimal, de 4 bits con hab. M=10"
      severity note;

      --------------------------------------------------- habilitado    
      ena_t <= '1';
      wait for 3 ns;
      ------------------------------------------ espera fin de reset             
      wait until rst_t='0';
      wait for 3 ns;
      assert tc_t='0'
         report "Error: se activo fin de cuenta en el arranque"
         severity failure;
 
      wait until rising_edge(clk_t); --------- 1, 0 lleg� en el reset 
      wait for 3 ns;
      assert q_t="0001"
         report "Error para q=0001"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 2 
      wait for 3 ns;
      assert q_t="0010"
         report "Error para q=0010"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 3 
      wait for 3 ns;
      assert q_t="0011"
         report "Error para q=0011"
         severity failure;	 
		 
      wait until rising_edge(clk_t); --------- 4
      wait for 3 ns;
      assert q_t="0100"
         report "Error para q=0100"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 5
      wait for 3 ns;
      assert q_t="0101"
         report "Error para q=0101"
         severity failure;	
		 
      wait until rising_edge(clk_t); --------- 6
      wait for 3 ns;
      assert q_t="0110"
         report "Error para q=0110"
         severity failure; 
		 
      wait until rising_edge(clk_t); --------- 7
      wait for 3 ns;
      assert q_t="0111"
         report "Error para q=0111"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 8
      wait for 3 ns;
      assert q_t="1000"
         report "Error para q=1000"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 9
      wait for 3 ns;
      assert q_t="1001"
         report "Error para q=1001"
         severity failure;
      assert tc_t='1'
         report "Error: no se activo fin de cuenta"
         severity failure;

      wait until rising_edge(clk_t); --------- 0   
      wait for 3 ns;
      assert q_t="0000"
         report "Error para q=0000"
         severity failure;  
		 
      wait until rising_edge(clk_t); --------- 1 
      wait for 3 ns;
      assert q_t="0001"
         report "Error para q=0001"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 2 		 
      wait for 3 ns;
      assert q_t="0010"
         report "Error para q=0010"
         severity failure;

      wait until rising_edge(clk_t); --------- 3 		 
      wait for 3 ns;
      assert q_t="0011"
         report "Error para q=0011"
         severity failure;
      ------------------------------------------------- inhabilitado    
      ena_t <= '0';                            
      wait for 3 ns;
      wait until rising_edge(clk_t); --------- 3 		 
      wait for 3 ns;
      assert q_t="0011"
         report "Error para q=0011, ena=0"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 3 		 
      wait for 3 ns;
      assert q_t="0011"
         report "Error para q=0011, ena=0"
         severity failure;	 
      --------------------------------------------------- habilitado        
      ena_t <= '1';                              
      wait for 3 ns;	 
      wait until rising_edge(clk_t); --------- 4 		 
      wait for 3 ns;
      assert q_t="0100"
         report "Error para q=0100"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 5
      wait for 3 ns;
      assert q_t="0101"
         report "Error para q=0101"
         severity failure;	
		 
      wait until rising_edge(clk_t); --------- 6
      wait for 3 ns;
      assert q_t="0110"
         report "Error para q=0110"
         severity failure; 
		 
      wait until rising_edge(clk_t); --------- 7
      wait for 3 ns;
      assert q_t="0111"
         report "Error para q=0111"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 8
      wait for 3 ns;
      assert q_t="1000"
         report "Error para q=1000"
         severity failure;
		 
      wait until rising_edge(clk_t); --------- 9
      wait for 3 ns;
      assert q_t="1001"
         report "Error para q=1001"
         severity failure;
      assert tc_t='1'
         report "Error: no se activo fin de cuenta"
         severity failure;

      wait until rising_edge(clk_t); --------- 0
      wait for 3 ns;
      assert q_t="0000"
         report "Error para q=0000"
         severity failure; 
      assert tc_t='0'
         report "Error: se activo fin de cuenta"
         severity failure;

      wait until rising_edge(clk_t); --------- 1
      wait for 3 ns;
      assert q_t="0001"
         report "Error para q=0001"
         severity failure; 
		 
      wait until rising_edge(clk_t); --------- 2 		 
      wait for 3 ns;
      assert q_t="0010"
         report "Error para q=0010"
         severity failure;

      wait until rising_edge(clk_t); --------- 3 		 
      wait for 3 ns;
      assert q_t="0011"
         report "Error para q=0011"
         severity failure;

      wait until rising_edge(clk_t); --------- 4 		 
      wait for 3 ns;
      assert q_t="0100"
         report "Error para q=0100"
         severity failure;
      ---------------------------------------------- se activo reset
      wait until rising_edge(clk_t); --------- 0
      wait for 3 ns;
      assert q_t="0000"
        report "Error para q=0000"
        severity failure;	
      -------------------------------------------- se inactivo reset      
      wait until rising_edge(clk_t); --------- 1 
      wait for 3 ns;
      assert q_t="0001"
        report "Error para q=0001"
        severity failure;
   
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;		
   end process Prueba;   
end architecture Test;
--------------------------------------------------------------------