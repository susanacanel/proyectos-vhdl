-- 16.09.19 ---------------------------------- Susana Canel ------------------------------ CompEntN_tb.vhdl
-- TESTBENCH DEL COMPARADOR DE ENTEROS DE 4 BITS.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------------------------------------------------------------
entity CompEntN_tb is
end entity CompEntN_tb;
-----------------------------------------------------------------------------------------------------------
architecture Test of CompEntN_tb is
   --------------------------------------------------
   component CompEntN
      generic(N     : positive:=4);
      port   (a_i   : in  std_logic_vector(N-1 downto 0);
              b_i   : in  std_logic_vector(N-1 downto 0);
              may_o : out std_logic;
              men_o : out std_logic; 
              igu_o : out std_logic);
   end component CompEntN;
   --------------------------------------------------
   signal   a_t        :  std_logic_vector(3 downto 0) :=(others=>'0');
   signal   b_t        :  std_logic_vector(3 downto 0) :=(others=>'0');
   signal   may_t      :  std_logic;
   signal   men_t      :  std_logic;
   signal   igu_t      :  std_logic;
   type     tabla1 is array (0 to 9) of std_logic_vector( 3 downto 0);
   type     tabla2 is array (0 to 9) of std_logic;
   constant ESTIMULO_A : tabla1 := ("0001","0100","1111","1110","1010","0111","0101","1110","1101","0111");
   constant ESTIMULO_B : tabla1 := ("0100","0000","0110","1101","1110","0111","1000","0000","1101","0110");
   constant MAYOR      : tabla2 := ('0',   '1',   '0',   '1',   '0',   '0',   '1',   '0',   '0',   '1');
   constant MENOR      : tabla2 := ('1',   '0',   '1',   '0',   '1',   '0',   '0',   '1',   '0',   '0');
   constant IGUAL      : tabla2 := ('0',   '0',   '0',   '0',   '0',   '1',   '0',   '0',   '1',   '0');	

begin
dut: CompEntN generic map(N     => 4)
	            port    map(a_i   => a_t,
            		          b_i   => b_t,
            		          may_o => may_t,
            		          men_o => men_t,
            		          igu_o => igu_t);
Prueba: process 
   begin
      report "Verificando el comparador de enteros de 4 bits"
      severity note;

      for i in tabla1'range loop
         a_t <= ESTIMULO_A(i);
         b_t <= ESTIMULO_B(i);
         wait for 1 ns;
         assert may_t = MAYOR(i)
            report "Falla mayor para a="& integer'image(to_integer(signed(a_t)))
                   & " y b=" & integer'image(to_integer(signed(b_t)))
            severity failure;
         assert men_t = MENOR(i)
            report "Falla menor para a="& integer'image(to_integer(signed(a_t)))
                   & " y b=" & integer'image(to_integer(signed(b_t)))
            severity failure;
         assert igu_t = IGUAL(i)
            report "Falla igual para a="& integer'image(to_integer(signed(a_t)))
                   & " y b=" & integer'image(to_integer(signed(b_t)))
            severity failure;
      end loop;		

      report "Verificacion exitosa!"
      severity note;
      wait;			
   end process Prueba;
end architecture Test;
-----------------------------------------------------------------------------------------------------------
