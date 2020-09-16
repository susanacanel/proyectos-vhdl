-- 25.06.2020 ----------- Susana Canel ------------- ContadorSec_tb.vhdl
-- TESTBENCHS DEL CONTADOR DE 3 BITS, CUENTA EN LA SECUENCIA: 4,3,7,1,0. 
-- SI SE PRODUCE UN ESTADO INDESEADO, EN UN PERIODO DE RELOJ ENTRA EN 
-- SECUENCIA. EL RESET SINCRONICO DA EL ESTADO INICIAL.

library ieee;  
use ieee.std_logic_1164.all;
------------------------------------------------------------------------
entity ContadorSec_tb is
end entity ContadorSec_tb;
------------------------------------------------------------------------
architecture Test of ContadorSec_tb is
  -------------------------------------------------
  component ContadorSec is
    port(rst_i : in  std_logic;
         clk_i : in  std_logic;
         q_o   : out std_logic_vector(2 downto 0));
  end component ContadorSec;
  -------------------------------------------------
  signal clk_t        : std_logic :='1';
  signal rst_t        : std_logic :='1';
  signal q_t          : std_logic_vector(2 downto 0);  
  constant FRECUENCIA : integer   := 50;              -- en MHz
  constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns=20
  signal   detener    : boolean   := false;    
begin
  dut: ContadorSec port map(clk_i => clk_t,
                            rst_i => rst_t,
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

  rst_t <= '1', '0' after PERIODO*3/2;

   Prueba:
   process begin
      report "Verificando Contador de secuencia 4,3,7,1,0"
      severity note;

      ------------------------------------------ espera fin de reset             
      wait until rst_t='0';
      wait for 3 ns;
 
      wait until rising_edge(clk_t); --------- 3 (el 4 durante el reset)
      wait for 3 ns;
      assert q_t="011"
        report "Error para q=011"
        severity failure;
		 
      wait until rising_edge(clk_t); --------- 7 
      wait for 3 ns;
      assert q_t="111"
        report "Error para q=111"
        severity failure;
		 
      wait until rising_edge(clk_t); --------- 1 
      wait for 3 ns;
      assert q_t="001"
        report "Error para q=001"
        severity failure;	 
		 
      wait until rising_edge(clk_t); --------- 0
      wait for 3 ns;
      assert q_t="000"
        report "Error para q=000"
        severity failure;
         		 
      wait until rising_edge(clk_t); --------- 4
      wait for 3 ns;
      assert q_t="100"
        report "Error para q=100"
        severity failure;

      wait until rising_edge(clk_t); --------- 3
      wait for 3 ns;
      assert q_t="011"
        report "Error para q=011"
        severity failure;
 		 
      wait until rising_edge(clk_t); --------- 7 
      wait for 3 ns;
      assert q_t="111"
        report "Error para q=111"
        severity failure;
       
      wait until rising_edge(clk_t); --------- 1 
      wait for 3 ns;
      assert q_t="001"
        report "Error para q=001"
        severity failure;	 
       
      wait until rising_edge(clk_t); --------- 0
      wait for 3 ns;
      assert q_t="000"
        report "Error para q=000"
        severity failure;
                
      wait until rising_edge(clk_t); --------- 4
      wait for 3 ns;
      assert q_t="100"
        report "Error para q=100"
        severity failure;

      wait until rising_edge(clk_t); --------- 3
      wait for 3 ns;
      assert q_t="011"
        report "Error para q=011"
        severity failure;

      wait until rising_edge(clk_t); --------- 7 
      wait for 3 ns;
      assert q_t="111"
        report "Error para q=111"
        severity failure;
	 
      wait until rising_edge(clk_t); --------- 1 
      wait for 3 ns;
      assert q_t="001"
        report "Error para q=001"
        severity failure;	 
     
      wait until rising_edge(clk_t); --------- 0
      wait for 3 ns;
      assert q_t="000"
        report "Error para q=000"
        severity failure;

      wait until rising_edge(clk_t); --------- 4
      wait for 3 ns;
      assert q_t="100"
        report "Error para q=100"
        severity failure;
   
      wait until rising_edge(clk_t); --------- 3
      wait for 3 ns;
      assert q_t="011"
        report "Error para q=011"
        severity failure;
        
      wait until rising_edge(clk_t); --------- 7 
      wait for 3 ns;
      assert q_t="111"
        report "Error para q=111"
        severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;		
   end process Prueba;   
end architecture Test;
--------------------------------------------------------------------