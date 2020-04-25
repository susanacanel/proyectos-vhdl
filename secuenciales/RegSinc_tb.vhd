-- 16.10.19 ---------- Susana Canel ------------ RegSinc_tb.vhdl
-- TESTBENCH PARA EL REGISTRO SINCRONICO DE 4 BITS

library ieee;   
use ieee.std_logic_1164.all;
----------------------------------------------------------------
entity RegSinc_tb is
end entity RegSinc_tb;
----------------------------------------------------------------
architecture Test of RegSinc_tb is
   -------------------------------------------------------
   component RegSinc is
      generic(N     : positive := 4);
      port   (clk_i : in  std_logic;
              rst_i : in  std_logic;
              d_i   : in  std_logic_vector(N-1 downto 0);
              q_o   : out std_logic_vector(N-1 downto 0));
   end component RegSinc;
   -------------------------------------------------------
   signal clk_t : std_logic := '1';
   signal rst_t : std_logic := '1';
   signal d_t   : std_logic_vector(3 downto 0) :="1111";
   signal q_t   : std_logic_vector(3 downto 0);
   constant FRECUENCIA : integer := 50;              -- en MHz
   constant PERIODO    : time    := 1 us/FRECUENCIA; -- 20 en ns
   signal detener      : boolean := false;	 
begin
dut : RegSinc generic map(N     => 4)
              port    map(clk_i => clk_t,
                          rst_i => rst_t,
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
      report "Verificando el registro sincronico de 4 bits"
      severity note;
      --------------------------------------------- activa reset      
      rst_t  <= '1';
      wait for 3 ns;                  -- ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		      -- tp y th
      assert q_t="0000"
         report "Falla para rst=1" 
         severity failure;
      ------------------------------------------- inactiva reset
      rst_t <= '0';
      d_t   <= "0001";
      wait for 3 ns;                  
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0001"
         report "Falla para 0001" 
         severity failure;
 	
      d_t   <= "0010";
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0010"
         report "Falla para 0010" 
         severity failure;		

      d_t   <= "1001";
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="1001"
         report "Falla para 1001" 
         severity failure;					
      --------------------------------------------- activa reset
      rst_t  <= '1';		
      d_t    <= "1111"; 
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;		           
      assert q_t="0000"
         report "Falla para rst=1" 
         severity failure;
      ------------------------------------------- inactiva reset			
      rst_t <= '0';
      d_t   <= "1011";
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="1011"
         report "Falla para 1011" 
         severity failure;					

      d_t   <= "0101";
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0101"
         report "Falla para 0101" 
         severity failure;
						
      d_t   <= "1100";	
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="1100"
         report "Falla para 1100" 
         severity failure;
						
      d_t   <= "0011";
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0011"
         report "Falla para 0011" 
         severity failure;					
      --------------------------------------------- activa reset	
      rst_t <= '1';					
      d_t   <= "1011";
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0000"
         report "Falla para rst=1" 
         severity failure;	
	
      d_t   <= "1101";
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0000"
         report "Falla para rst=1" 
         severity failure;	
      ------------------------------------------- inactiva reset
      rst_t <= '0';
      d_t   <= "1010";
      wait for 3 ns;		
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="1010"
         report "Falla para 1010" 
         severity failure;

      d_t   <= "1110";
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="1110"
         report "Falla para 1110" 
         severity failure;					

      d_t   <= "0111";
      wait for 3 ns;
      wait until rising_edge(clk_t);
      wait for 5 ns;
      assert q_t="0111"
         report "Falla para 0111" 
         severity failure;	

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;
                      								  
end architecture Test;
----------------------------------------------------------------