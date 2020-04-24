-- 29.03.19 --------- Susana Canel ----------- SumResEntN_tb.vhdl
-- TESTBENCH DE UN SUMADOR Y RESTADOR DE ENTEROS DE N BITS
library ieee; 
use ieee.std_logic_1164.all; 
-----------------------------------------------------------------
entity SumResEntN_tb is
end entity SumResEntN_tb;
-----------------------------------------------------------------
architecture Test of SumResEntN_tb is
   --------------------------------------------------------------
   component SumResEntN is
      generic(N     : positive:= 3);
      port   (a_i   :  in std_logic_vector(N-1 downto 0);
	      b_i   :  in std_logic_vector(N-1 downto 0);
	      mod_i :  in std_logic;
	      sal_o : out std_logic_vector(N-1 downto 0);
	      v_o   : out std_logic   );
   end component SumResEntN;
   --------------------------------------------------------------
   signal a_t   : std_logic_vector(3 downto 0) := (others=>'0'); 
   signal b_t   : std_logic_vector(3 downto 0) := (others=>'0');
   signal mod_t : std_logic := '0';
   signal sal_t : std_logic_vector(3 downto 0);
   signal v_t   : std_logic;
begin
dut : SumResEntN generic map(N      => 4) 
	         port    map(a_i    => a_t, 
                             b_i    => b_t,
                             mod_i  => mod_t,
		             sal_o  => sal_t,	
                             v_o    => v_t);					  
Prueba:
   process begin
      report "Verificando sumador/restador, enteros de 4 bits"
      severity note;
      
      mod_t <= '0';  ------------------------------------ suma
		
      a_t  <= "0000";        --  0 
      b_t  <= "0001";        --  1  		
      wait for 1 ns;
      assert sal_t="0001"
         report "Falla para suma a=0000, b=0001"
         severity failure;
      assert v_t='0'
         report "Falla ov para suma a=0000, b=0001"
         severity failure;	  

      a_t  <= "1101";        -- -3
      b_t  <= "1001";        -- -7		
      wait for 1 ns;
      assert sal_t="0110"
         report "Falla para suma a=1101, b=1001"
         severity failure;         
      assert v_t='1'
         report "Falla ov para suma a=1101, b=1001"
         severity failure;
		    
      a_t  <= "0010";        --  2 
      b_t  <= "0110";        --  6  		
      wait for 1 ns;
      assert sal_t="1000"
         report "Falla para suma a=0010, b=0110"
         severity failure;  
      assert v_t='1'
         report "Falla ov para suma a=0010, b=0110"
         severity failure;
		  
      a_t  <= "1000";        -- -8  
      b_t  <= "0011";        --  3   		
      wait for 1 ns;
      assert sal_t="1011"
         report "Falla para suma a=1000, b=0011"
         severity failure;  
      assert v_t='0'
         report "Falla ov para suma a=1000, b=0011"
         severity failure;
		  		  
      a_t  <= "1011";        -- -5
      b_t  <= "1001";        -- -7		
      wait for 1 ns;
      assert sal_t="0100"
         report "Falla para suma a=1011, b=1001"
         severity failure;
      assert v_t='1'
         report "Falla ov para suma a=1011, b=1001"
         severity failure;
		  
      a_t  <= "0111";        --  7 
      b_t  <= "1110";        -- -2   		
      wait for 1 ns;
      assert sal_t="0101"
         report "Falla para suma a=0111, b=1110"
         severity failure;
      assert v_t='0'
         report "Falla ov para suma a=0111, b=1110"
         severity failure;
		    
      a_t  <= "1000";        -- -8 
      b_t  <= "0111";        --  7  		
      wait for 1 ns;
      assert sal_t="1111"
         report "Falla para suma a=1000, b=0111"
         severity failure;  
      assert v_t='0'
         report "Falla ov para suma a=1000, b=0111"
         severity failure;
		  		  
      a_t  <= "1101";        -- -3
      b_t  <= "0001";        --  1  		
      wait for 1 ns;
      assert sal_t="1110"
         report "Falla para suma a=1101, b=0001"
         severity failure;
      assert v_t='0'
         report "Falla ov para suma a=1101, b=0001"
         severity failure;

      mod_t <= '1';  ----------------------------------- resta	
		
      a_t  <= "1101";        -- -2
      b_t  <= "1001";        -- -7
      wait for 1 ns;
      assert sal_t="0100"
         report "Falla para resta a=1101, b=1001"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=1101, b=1001"
         severity failure;
		  
      a_t  <= "1011";        -- -5
      b_t  <= "1101";        -- -3		
      wait for 1 ns;
      assert sal_t="1110"
         report "Falla para resta a=1011, b=1101"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=1011, b=1101"
         severity failure;
		  
      a_t  <= "0110";        -- 6
      b_t  <= "0011";        -- 3		
      wait for 1 ns;
      assert sal_t="0011"
         report "Falla para resta a=0110, b=0011"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=0110, b=0011"
         severity failure;
		  		  
      a_t  <= "0111";        --  7
      b_t  <= "1000";        -- -8		
      wait for 1 ns;
      assert sal_t="1111"
         report "Falla para resta a=0111, b=1000"
         severity failure;
      assert v_t='1'
         report "Falla overflow para resta a=0111, b=1000"
         severity failure;

      a_t  <= "0101";        -- 5
      b_t  <= "0011";        -- 3		
      wait for 1 ns;
      assert sal_t="0010"
         report "Falla para resta a=0101, b=0011"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=0101, b=0011"
         severity failure;
		  
      a_t  <= "1001";        -- -7
      b_t  <= "1010";        -- -6		
      wait for 1 ns;
      assert sal_t="1111"
         report "Falla para resta a=1001, b=1010"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=1001, b=1010"
         severity failure;

      a_t  <= "1111";        -- -1
      b_t  <= "1011";        -- -5		
      wait for 1 ns;
      assert sal_t="0100"
         report "Falla para resta a=1111, b=1011"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=1111, b=1011"
         severity failure;

      a_t  <= "0011";        --  3
      b_t  <= "0100";        --  4		
      wait for 1 ns;
      assert sal_t="1111"
         report "Falla para resta a=0011, b=0100"
         severity failure;
      assert v_t='0'
         report "Falla overflow para resta a=0011, b=0100"
         severity failure;
		  
      report "¡Verificación exitosa!"
      severity note;
      wait;
    end process Prueba;                      
end architecture Test;
-----------------------------------------------------------------
		