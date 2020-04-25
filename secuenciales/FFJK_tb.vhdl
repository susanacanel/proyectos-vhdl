-- 13.08.19 ----------- Susana Canel ----------- FFJK_tb.vhdl  
-- TESTBENCH DEL FLIP-FLOP JK, DISPARADO POR FLANCO POSITIVO.

library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------
entity FFJK_tb is
end entity FFJK_tb;
--------------------------------------------------------------
architecture Test of FFJK_tb is 
   -----------------------------
   component FFJK is
   port(j_i    : in  std_logic;
        k_i    : in  std_logic;
        clk_i  : in  std_logic; 
        q_o    : out std_logic);
   end component FFJK;
   -----------------------------
   signal j_t          : std_logic := '0';
   signal k_t          : std_logic := '0';
   signal clk_t        : std_logic := '0';
   signal q_t          : std_logic;
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns
   signal detener      : boolean   := false;
	
begin
dut : FFJK port map(j_i   => j_t,
                    k_i   => k_t,
                    clk_i => clk_t, 
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
      report "Verificando el ff JK"
      severity note;
	
      -------------------------------------------------- setea
      j_t  <= '1';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=1" 
         severity warning;
     --------------------------------------------- complementa      
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=1, k=0" 
         severity warning;
     --------------------------------------------- complementa
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=1" 
         severity warning;
      ------------------------------------------------ resetea
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=1, k=1" 
         severity warning;
      -------------------------------------------------- setea	
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns	
      j_t  <= '1';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=0" 
         severity warning;			
      ------------------------------------------------ resetea	
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns		
      wait for 10 ns;
      j_t  <= '0';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=0, k=1" 
         severity warning;
      ----------------------------------------------- memoriza	
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns		
      wait for 10 ns;
      j_t  <= '0';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=0, k=0" 
         severity warning;
      -------------------------------------------- complementa			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=1" 
         severity warning;
      ------------------------------------------- complementa		
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=1, k=1" 
         severity warning;
     ------------------------------------------------ memoriza			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=0, k=0" 
         severity warning;
     --------------------------------------------- complementa		
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=1" 
         severity warning;
     ------------------------------------------------ memoriza			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=0, k=0" 
         severity warning;
      -------------------------------------------------- setea		
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns			
      j_t  <= '1';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=0" 
         severity warning;
      -------------------------------------------------- setea		
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns			
      j_t  <= '1';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=0" 
         severity warning;
     --------------------------------------------- complementa
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=1" 
         severity warning;
     --------------------------------------------- complementa
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '1';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=1, k=1" 
         severity warning;
      ----------------------------------------------- memoriza			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=0, k=0" 
         severity warning;
      ----------------------------------------------- memoriza			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '0';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='1'
         report "Falla para j=0, k=0" 
         severity warning;
      ------------------------------------------------ resetea			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=0, k=1" 
         severity warning;
      ------------------------------------------------ resetea			
      wait for 5 ns;  ---- genera un pulso de 10ns = (3+2+5)ns
      j_t  <= '0';
      k_t  <= '1';
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;          
      assert q_t='0'
         report "Falla para j=0, k=1" 
         severity warning;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;                      	
end architecture Test;
--------------------------------------------------------------
