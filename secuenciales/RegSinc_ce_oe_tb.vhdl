-- 21.10.19 -------- Susana Canel ------- RegSinc_ce_oe_tb.vhdl
-- TESTBENCH DE UN REGISTRO SINCRONICO, DE 4 BITS, CON RESET,
-- HABILITACION DEL REGISTRO Y SALIDA DE ALTA IMPEDANCIA.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------
entity RegSinc_ce_oe_tb is
end entity RegSinc_ce_oe_tb;
---------------------------------------------------------------
architecture Test of RegSinc_ce_oe_tb is
   -------------------------------------------------------
   component RegSinc_ce_oe is
      generic(N     : positive := 4);
      port   (clk_i : in  std_logic;
              rst_i : in  std_logic;	     
              ce_i  : in  std_logic;
              oe_i  : in  std_logic;
              d_i   : in  std_logic_vector(N-1 downto 0);
              q_o   : out std_logic_vector(N-1 downto 0));
   end component RegSinc_ce_oe;
   -------------------------------------------------------
   signal clk_t : std_logic := '1';
   signal rst_t : std_logic := '1';
   signal ce_t  : std_logic := '0';
   signal oe_t  : std_logic := '0';
   signal d_t   : std_logic_vector(3 downto 0) :="1111";
   signal q_t   : std_logic_vector(3 downto 0);
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- 20 ns
   signal detener      : boolean := false;	 
begin
dut : RegSinc_ce_oe generic map(N     => 4)
                    port    map(clk_i => clk_t,
                                rst_i => rst_t,
                                ce_i  => ce_t,
                                oe_i  => oe_t,
                                d_i   => d_t,
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
      report "Verificando reg. sincronico de 4 bits, ce, oe"
      severity note;
      ------------------------------------         activa reset 
      ------------------------------------ habilita el registro 
      ------------------------------------   habilita la salida    
      rst_t  <= '1';                  
      ce_t   <= '1';
      oe_t   <= '1';
      d_t   <= "0101";
      wait for 5 ns;                  -- tp y genera ts
      wait until rising_edge(clk_t);
      wait for 4 ns;		      -- tp y genera th
      assert q_t="0000"
         report "Falla para rst=1, ce=1, oe=1" 
         severity failure;
      ------------------------------------------ inactiva reset
      rst_t <= '0';
      d_t   <= "0001";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0001"
         report "Falla para 0001, ce=1, oe=1" 
         severity failure;
		
      d_t   <= "0010";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0010"
         report "Falla para 0010, ce=1, oe=1" 
         severity failure;		
 
      d_t   <= "1001";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="1001"
         report "Falla para 1001, ce=1, oe=1" 
         severity failure;					
      -------------------------------------------- activa reset 
      rst_t  <= '1';		            
      d_t    <= "1111"; 
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;		           
      assert q_t="0000"
         report "Falla para rst=1, ce=1, oe=1" 
         severity failure;
      ------------------------------------------ inactiva reset 
      rst_t <= '0';  
      d_t   <= "1010";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="1010"
         report "Falla para 1010, ce=1, oe=1" 
         severity failure;   
          
      d_t   <= "0111";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0111"
         report "Falla para 0111, ce=1, oe=1" 
         severity failure;					
      ------------------------------------ inhabilita la salida
      d_t   <= "0101";
      wait for 5 ns;	
      wait until rising_edge(clk_t);
      oe_t  <= '0';	
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para 0111, ce=1, oe=0" 
         severity failure;

      d_t   <= "0110";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para 0110, ce=1, oe=0" 
         severity failure;
      -------------------------------------- habilita la salida
      d_t   <= "0101";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      oe_t  <= '1';
      wait for 4 ns;
      assert q_t="0101"
         report "Falla para 0101, ce=1, oe=1" 
         severity failure;
			
      d_t   <= "1100";	
      wait for 5 ns;				
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="1100"
         report "Falla para 1100, ce=1, oe=1" 
         severity failure;
						
      d_t   <= "0011";	
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0011"
         report "Falla para 0011, ce=1, oe=1" 
         severity failure;					
      -------------------------------------------- activa reset	
      ------------------------------------ inhabilita la salida	
      rst_t <= '1';				
      d_t   <= "1011";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      oe_t  <= '0';
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para rst=1, ce=1, oe=0" 
         severity failure;	
      ------------------------------------------ inactiva reset
      rst_t <= '0';
      d_t   <= "1010";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para 1010, ce=1, oe=0" 
         severity failure;
      -------------------------------------- habilita la salida
      d_t   <= "0101";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      oe_t  <= '1';
      wait for 4 ns;
      assert q_t="0101"
         report "Falla para 0101, ce=1, oe=1" 
         severity failure;
      ---------------------------------- inhabilita el registro		
      ce_t  <= '0'; 				
      d_t   <= "1011";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0101"
         report "Falla para 0101, ce=0, oe=1" 
         severity failure; 

      d_t   <= "1000";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0101"
         report "Falla para 0101, ce=0, oe=1" 
         severity failure; 
      ------------------------------------ inhabilita la salida				
      d_t   <= "0011";
      wait for 5 ns;			
      wait until rising_edge(clk_t);
      oe_t  <= '0';
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para ZZZZ, ce=0, oe=0" 
         severity failure;	
				
      d_t   <= "1011";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para ce=0, oe=0" 
         severity failure;		
      -------------------------------------------- activa reset		
      rst_t <= '1';
      d_t   <= "1111";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para rst=1, ce=0, oe=0" 
         severity failure;					
      ------------------------------------ habilita el registro						
      ce_t  <= '1';  
      d_t   <= "1001";              
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="ZZZZ"
         report "Falla para rst=1, ce=1, oe=0" 
         severity failure; 
      -------------------------------------- habilita la salida
      d_t   <= "0101";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      oe_t  <= '1';
      wait for 4 ns;
      assert q_t="0000"
         report "Falla para rst=1, ce=1, oe=1" 
         severity failure;
			
      d_t   <= "0110";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0000"
         report "Falla para rst=1, ce=1, oe=1" 
         severity failure;
      ---------------------------------- inhabilita el registro		
      d_t   <= "1110";
      ce_t  <= '0';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0000"
         report "Falla para rst=1, ce=0, oe=1" 
         severity failure;
      ------------------------------------------ inactiva reset		
      rst_t <= '0';				
      d_t   <= "1010";
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0000"
         report "Falla para 1010, ce=0, oe=1" 
         severity failure;	
      ------------------------------------ habilita el registro
      d_t   <= "0010";
      ce_t  <= '1';
      wait for 5 ns;		
      wait until rising_edge(clk_t);
      wait for 4 ns;
      assert q_t="0010"
         report "Falla para 0010, ce=1, oe=1" 
         severity failure;
			
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;                      								  
end architecture Test;
---------------------------------------------------------------