-- 22.04.20 ----------- Susana Canel ------------- JohnsonM8corrige_tb.vhdl
-- TESTBENCH DEL CONTADOR JOHNSON O MOEBIUS MODULO PAR.
library ieee;    
use ieee.std_logic_1164.all;
---------------------------------------------------------------------------
entity Johnson_tb is
end entity Johnson_tb;
---------------------------------------------------------------------------
architecture Test of Johnson_tb is
   ------------------------------------------------------
   component Johnson is
      generic(N     : positive := 4);
      port   (clk_i : in  std_logic; 
              rst_i : in  std_logic; 					 
              sel_i : in  std_logic_vector(1 downto 0);
              q_o   : out std_logic_vector(N-1 downto 0)); 
   end component Johnson;
   ------------------------------------------------------
   signal   clk_t      : std_logic :='1';
   signal   rst_t      : std_logic :='1';
   signal   sel_t      : std_logic_vector(1 downto 0) :="00";
   signal   q_t        : std_logic_vector(3 downto 0);
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns
   signal   detener    : boolean   := false;	 	
begin
   dut: Johnson generic map(N     => 4)
                port    map(clk_i => clk_t,
                            rst_i => rst_t,
                            sel_i => sel_t,
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
      report "Verificando contador Johnson de 4 bits con estados prohibidos"
      severity note;
		
      wait until rst_t='0'; 
      ----------------------------------------------- funcionamiento normal 
      sel_t <= "00";
      wait for 5 ns;			   -- genera ts
      wait until rising_edge(clk_t);		            		           
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);		           
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);		           

      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);

      ---------------------------------------------------- genera el "1010" 
      sel_t <= "01";		
      wait for 5 ns;		
      wait until rising_edge(clk_t);	
	           
      sel_t <= "00";
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      ---------------------------------------------------- genera el "0110" 
      sel_t <= "10";
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      sel_t <= "00";
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);

      ---------------------------------------------------- genera el "0100"	
      sel_t <= "11";
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      sel_t <= "00";
      wait for 5 ns;	 	
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);
	
      wait for 5 ns;		
      wait until rising_edge(clk_t);

      wait for 5 ns;		
      wait until rising_edge(clk_t);

      detener <= true;
      wait;
   end process Prueba; 
                     								  
end architecture Test;
---------------------------------------------------------------------------
 