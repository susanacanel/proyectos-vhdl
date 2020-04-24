-- 30.03.19 ------------- Susana Canel -------------------- ROM_Nat2Gray_tb.vhdl
-- TESTBENCH DE LA ROM QUE CONTIENE EL CODIGO GRAY
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------------
entity ROM_Nat2Gray_tb is
end entity ROM_Nat2Gray_tb;
-------------------------------------------------------------------------------
architecture Test of ROM_Nat2Gray_tb is
   ----------------------------------------------------------------------------
   component ROM_Nat2Gray is
      generic(BITS   : integer := 4; 	 -- 4 bits por palabra
              DIREC  : integer := 4); 	 -- 4 lineas de direcciones: 16 palabras
      port   (dir_i  : in  std_logic_vector(DIREC-1 downto 0);
              ena_i  : in  std_logic;
              dat_o  : out std_logic_vector(BITS-1 downto 0));			  
   end component ROM_Nat2Gray;
   ----------------------------------------------------------------------------
   signal dir_t : std_logic_vector(1 to 4):= (others=>'0');
   signal ena_t : std_logic := '0';
   signal dat_t : std_logic_vector(3 downto 0);
begin
dut : ROM_Nat2Gray generic map(BITS  => 4,
                               DIREC => 4)
                   port    map(dir_i => dir_t,
		               ena_i => ena_t,
			       dat_o => dat_t);
Prueba:
   process begin
      report "Verificando la ROM que contiene el codigo Gray de 4 bits"
      severity note;
      
      ena_t <= '1';    ---------------------------------------- ROM habilitada        
      dir_t <= "1001";
      wait for 1 ns;
      assert dat_t="1101"
         report "Falla para 1001"
         severity failure;

      ena_t <= '1';       
      dir_t <= "0001";
      wait for 1 ns;
      assert dat_t="0001"
         report "Falla para 0001"
         severity failure;       

      ena_t <= '0';    ---------------------------------------- ROM inhabilitada            
      dir_t <= "1001";
      wait for 1 ns;
      assert dat_t="ZZZZ"
         report "Falla para ena=0"
        severity failure;
		  
      ena_t <= '1';    ---------------------------------------- ROM habilitada
      dir_t <= "0101";
      wait for 1 ns;
      assert dat_t="0111"
         report "Falla para 0101"
         severity failure; 

      ena_t <= '0';     --------------------------------------- ROM inhabilitada       
      dir_t <= "0001";
      wait for 1 ns;
      assert dat_t="ZZZZ"
         report "Falla para ena=0"
         severity failure;       
      
      ena_t <= '0';
      dir_t <= "0101";
      wait for 1 ns;
      assert dat_t="ZZZZ"
         report "Falla para ena=0"
         severity failure;	
      
      ena_t <= '1';    ---------------------------------------- ROM habilitada            
      dir_t <= "0011";
      wait for 1 ns;
      assert dat_t="0010"
         report "Falla para 0011"
         severity failure;
      
      ena_t <= '0';     --------------------------------------- ROM inhabilitada 
      dir_t <= "0111";
      wait for 1 ns;
      assert dat_t="ZZZZ"
         report "Falla para ena=0"
         severity failure;	
		  
      ena_t <= '1';    ---------------------------------------- ROM habilitada       
      dir_t <= "0000";
      wait for 1 ns;
      assert dat_t="0000"
         report "Falla para 0000"
         severity failure;       
      
      ena_t <= '1';            
      dir_t <= "0010";
      wait for 1 ns;
      assert dat_t="0011"
         report "Falla para 0010"
         severity failure;
      
      ena_t <= '1';            
      dir_t <= "0100";
      wait for 1 ns;
      assert dat_t="0110"
         report "Falla para 0100"
         severity failure;
		  		  
      report "¡Verificación exitosa!"
      severity note;
      wait;
    end process Prueba;                      
end architecture Test;
---------------------------------------------------------------------------------
