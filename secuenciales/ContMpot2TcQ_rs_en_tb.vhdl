-- 29.08.19 ------- Susana Canel ------ ContMpot2TcQ_rs_en_tb.vhdl
-- TESTBENCHS DEL CONTADOR GENERICO, SINCRONICO BINARIO, MODULO 
-- POTENCIA DE DOS, CON RESET SINCRONICO Y HABILITACION.
-- SALIDAS: ESTADO Y CUENTA TERMINAL.

library ieee;  
use ieee.std_logic_1164.all;
------------------------------------------------------------------
entity ContMpot2TcQ_rs_en_tb is
end entity ContMpot2TcQ_rs_en_tb;
------------------------------------------------------------------
architecture Test of ContMpot2TcQ_rs_en_tb is
   ----------------------------------------------------
   component ContMpot2TcQ_rs_en is
      generic(N     : positive := 3);
      port   (clk_i : in  std_logic;
              rst_i : in  std_logic;
              ena_i : in  std_logic;
              q_o   : out std_logic_vector(N-1 downto 0);
              tc_o  : out std_logic);
   end component ContMpot2TcQ_rs_en;
   ------------------------------------------------------
   signal   clk_t      : std_logic := '1';
   signal   rst_t      : std_logic := '1';
   signal   ena_t      : std_logic := '0';
   signal   q_t        : std_logic_vector(2 downto 0);
   signal   tc_t       : std_logic;              
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns: 20
   signal   detener    : boolean   := false;  
begin
   dut: ContMpot2TcQ_rs_en generic map(N     => 3)
                           port    map(clk_i => clk_t,
                                       rst_i => rst_t,
                                       ena_i => ena_t,
                                       q_o   => q_t,
                                       tc_o  => tc_t);
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
      report "Verificando el contador de 3 bits, con hab., M=8"
      severity note;
   
      rst_t <= '1', '0' after PERIODO * 3 / 2;

      -------------------------------------------------- habilita
      ---------------------------- espera que reset este inactivo
      ------------------------ (el primer flanco creciente de clk 
      -------------------- durante el reset puso la cuenta en 000)

      ena_t <= '1'; 
      wait for 3 ns;
      wait until rst_t='0';
      wait for 3 ns;    
      wait until rising_edge(clk_t); -------  1 
      wait for 3 ns;
      assert q_t="001"
         report "Error para q=001"
         severity failure;
      assert tc_t='0'
         report "Error: se activo fin de cuenta en el arranque"
         severity failure;
		 
      wait until rising_edge(clk_t); -------  2 
      wait for 3 ns;
      assert q_t="010"
         report "Error para q=010"
         severity failure;
		 
      wait until rising_edge(clk_t); -------  3 
      wait for 3 ns;
      assert q_t="011"
         report "Error para q=011"
         severity failure;	 
		 
      wait until rising_edge(clk_t); -------  4
      wait for 3 ns; 
      assert q_t="100"
         report "Error para q=100"
         severity failure;
		 
      wait until rising_edge(clk_t); -------  5
      wait for 3 ns; 
      assert q_t="101"
         report "Error para q=101"
         severity failure;  
      assert tc_t='0'
         report "Error: se activo la cuenta terminal en 5"
         severity failure;  
		 
      wait until rising_edge(clk_t); -------  6
      wait for 3 ns; 
      assert q_t="110"
         report "Error para q=110"
         severity failure;	
		 
      wait until rising_edge(clk_t); -------  7 
      wait for 3 ns; 
      assert q_t="111"
         report "Error para q=111"
         severity failure;	   
      assert tc_t='1'
         report "Error: no detecto la cuenta terminal"
         severity failure;  
	 
      wait until rising_edge(clk_t); -------  0   
      wait for 3 ns; 
      assert q_t="000"
         report "Error para q=000"
       severity failure; 
      assert tc_t='0'
         report "Error: se activo la cuenta terminal en 0"  
         severity failure; 
		 
      wait until rising_edge(clk_t); -------  1 
      wait for 3 ns; 
      assert q_t="001"
         report "Error para q=001"
       severity failure;
		 
      wait until rising_edge(clk_t); -------  2 
      wait for 3 ns; 
      assert q_t="010"
         report "Error para q=010"
         severity failure;
      assert tc_t='0'
         report "Error: se activo la cuenta terminal en 2"
         severity failure; 
		 
      wait until rising_edge(clk_t); -------  3 
      wait for 3 ns; 
      assert q_t="011"
         report "Error para q=011"
         severity failure;  
		 
      wait until rising_edge(clk_t); -------  4
      wait for 3 ns; 
      assert q_t="100"
         report "Error para q=100"
       severity failure;  
      ------------------------------------------------- inhabilita
      ena_t <= '0'; 
      wait for 3 ns;
      wait until rising_edge(clk_t); -------  5
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100" ---- se congela en 4
         severity failure;

      wait for 3 ns;
      wait until rising_edge(clk_t); -------  6
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100" 
         severity failure;

      wait for 3 ns;
      wait until rising_edge(clk_t); -------  7
      wait for 3 ns;
      assert q_t="100"
         report "Error para q=100" 
         severity failure;
      assert tc_t='0'
         report "Error: hubo cuenta terminal y no esta habilitado"
         severity failure;   
      --------------------------------------------------- habilita
      ena_t <= '1'; 
      wait for 3 ns;                               
      wait until rising_edge(clk_t); -------  5
      wait for 3 ns; 
      assert q_t="101"
         report "Error para q=101"
         severity failure;  
 	 
      wait until rising_edge(clk_t); -------  6
      wait for 3 ns; 
      assert q_t="110"
         report "Error para q=110"
         severity failure;	
		 
      wait until rising_edge(clk_t); -------  7 
      wait for 3 ns; 
      assert q_t="111"
         report "Error para q=111"
         severity failure;	   
      assert tc_t='1'
         report "Error: no detecto la cuenta terminal"
         severity failure;
	 
      wait until rising_edge(clk_t); -------  0   
      wait for 3 ns; 
      assert q_t="000"
         report "Error para q=000"
       severity failure;  
		 
      wait until rising_edge(clk_t); -------  1 
      wait for 3 ns; 
      assert q_t="001"
         report "Error para q=001"
       severity failure;
		 
      wait until rising_edge(clk_t); -------  2 
      wait for 3 ns; 
      assert q_t="010"
         report "Error para q=010"
         severity failure;
      ---------------------------------------------------- resetea
      rst_t <= '1';
      wait for 3 ns;
      wait until rising_edge(clk_t); -------  0 
      wait for 3 ns; 	 
      assert q_t="000"
         report "Error para rst=1"
         severity failure;
      assert tc_t='0'
         report "Error: se activo fin de cuenta en el reset"
         severity failure;
      --------------------------------------------- inactiva reset	 
      rst_t <= '0';
      wait for 3 ns;
      wait until rising_edge(clk_t); -------  1 
      wait for 3 ns; 	 
      assert q_t="001"
         report "Error para rst=0"
         severity failure;		   
	 
      wait until rising_edge(clk_t); -------  2   
      wait for 3 ns; 
      assert q_t="010"
         report "Error para q=010"
         severity failure;  
                	                          	           
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;		
   end process Prueba;   
end architecture Test;
------------------------------------------------------------------