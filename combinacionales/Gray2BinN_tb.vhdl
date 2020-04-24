-- 26.03.19 --------------- Susana Canel --------------- Gray2BinN_tb.vhdl
-- TESTBENCH PARA EL CONVERSOR GENERICO DE CODIGO GRAY A BINARIO
library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------
entity Gray2BinN_tb is
end entity Gray2BinN_tb;
--------------------------------------------------------------------------
architecture Test of Gray2BinN_tb is
   ------------------------------------------------------
   component Gray2BinN is
      generic(N    : integer:=4);
      port   (g_i  : in  std_logic_vector(N-1 downto 0);
              b_o  : out std_logic_vector(N-1 downto 0));	
   end component Gray2BinN;
   ------------------------------------------------------
   signal g_t  : std_logic_vector (3 downto 0) := (others => '0');
   signal b_t  : std_logic_vector (3 downto 0);
   type tabla is array(0 to 2**4-1) of std_logic_vector(3 downto 0);
   constant TABLA_GRAY : tabla := ("0000", "0001", "0011", "0010",
                                   "0110", "0111", "0101", "0100",
				   "1100", "1101", "1111", "1110",
				   "1010", "1011", "1001", "1000");
begin
dut: Gray2BinN generic map(N   => 4)
               port    map(g_i => g_t,
			   b_o => b_t);
Prueba:
   process begin
      report "Probando el conversor de Gray a binario de 4 bits"
      severity note;
				
      for i in tabla'range loop
	 g_t <= TABLA_GRAY(i);
	 wait for 1 ns;
	 assert b_t = std_logic_vector(to_unsigned(i, 4))
	    report "Falla para "& integer'image(to_integer(unsigned(g_t)))
	    severity failure;
      end loop;
		
      report "!Prueba exitosa!"
      severity note;
      wait;
   end process Prueba;
	
end architecture Test;
--------------------------------------------------------------------------
