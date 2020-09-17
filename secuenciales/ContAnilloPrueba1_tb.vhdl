-- 16.09.20 -------------- Susana Canel ------------- ContAnilloPrueba1_tb.vhdl
-- TESTBENCH DEL CONTADOR EN ANILLO CON ARRANQUE AUTOMATICO.
library ieee;   
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
entity ContAnilloPrueba1_tb is
end entity ContAnilloPrueba1_tb;
-------------------------------------------------------------------------------
architecture Test of ContAnilloPrueba1_tb is
   ------------------------------------------------------
   component ContAnilloPrueba1 is
     generic(N     : positive := 6);
     port   (clk_i : in  std_logic; 
             rst_i : in  std_logic; 
             sel_i : in  std_logic_vector(1 downto 0);					 
             q_o   : out std_logic_vector(N-1 downto 0)); 
   end component ContAnilloPrueba1;
   ------------------------------------------------------
   signal   clk_t      : std_logic :='1';
   signal   rst_t      : std_logic :='1';
   signal   sel_t      : std_logic_vector(1 downto 0) :="00";
   signal   q_t        : std_logic_vector(4 downto 0);
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns
   signal   detener    : boolean   := false;	 	
begin
   dut: ContAnilloPrueba1 generic map(N     => 5)
                          port    map(clk_i => clk_t,
                                      rst_i => rst_t,
                                      sel_i => sel_t,
                                      q_o   => q_t);
   -- GeneraReloj ----------------------						  
   process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
         wait;
      end if;
   end process;
   -------------------------------------
   rst_t <= '1', '0' after PERIODO*3/2, '1' after 122 ns, '0' after 145 ns, '1' 
   after 242 ns, '0' after 265 ns, '1' after 362 ns, '0' after 385 ns;

   Prueba: 		 
   process begin
      report "Verificando contador en anillo arranque atomatico, de 5 bits"
      severity note;

      ------------------------------------------------- sel=00, reset con 10000
      sel_t <= "00";		
      wait until rst_t='0';  
      wait for 5 ns;			              -- genera ts
      wait until rising_edge(clk_t);
      wait for 2 ns;		                -- espera tp  	           		           

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;	

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           
		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           	             		           
      ------------------------------------------------- sel=11, reset con 11111
      sel_t <= "11";		
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;			   
      wait until rising_edge(clk_t);
      wait for 2 ns;		             	           		           

      wait for 5 ns;			   
      wait until rising_edge(clk_t);
      wait for 2 ns;		             	           		           

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	 	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           	           
      ------------------------------------------------- sel=01, reset con 10111	           
      sel_t <= "01";
      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;	

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           		           
      ------------------------------------------------- sel=10, reset con 00000	           
      sel_t <= "10";
      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;	

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		           

      wait for 5 ns;	            	
      wait until rising_edge(clk_t);
      wait for 2 ns;		                      	           

      detener <= true;
      wait;
   end process Prueba; 
                     								  
end architecture Test;
-------------------------------------------------------------------------------
 