-- 29.03.19 ---------------------------- Susana Canel ---------------------------------- SumMagN_tb.vhdl
-- TESTBENCH DE UN SUMADOR BINARIO GENERICO DE MAGNITUDES, N BITS

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
--------------------------------------------------------------------------------------------------------
entity SumMagN_tb is
end entity SumMagN_tb;
--------------------------------------------------------------------------------------------------------
architecture Test of SumMagN_tb is 
   ------------------------------------------------------
   component SumMagN is
      generic(N     : positive:=2); 
      port   (a_i   : in  std_logic_vector(N-1 downto 0); 
	      b_i   : in  std_logic_vector(N-1 downto 0); 
	      ci_i  : in  std_logic_vector(0   downto 0); 
	      sum_o : out std_logic_vector(N-1 downto 0);
	      co_o  : out std_logic);
   end component SumMagN;
   ------------------------------------------------------
   signal a_t  : std_logic_vector(2 downto 0) := (others=>'0'); 
   signal b_t  : std_logic_vector(2 downto 0) := (others=>'0');	
   signal ci_t : std_logic_vector(0 downto 0) := "0"; 
   signal su_t : std_logic_vector(2 downto 0);
   signal co_t : std_logic;
   type tabla1 is array (0 to 10) of std_logic_vector(2 downto 0);
   type tabla2 is array (0 to 10) of std_logic_vector(0 downto 0);
   type tabla3 is array (0 to 10) of std_logic;
   constant ESTIMULO_A  : tabla1 := ("010","011","110","010","111","110","100","111","000","011","100");
   constant ESTIMULO_B  : tabla1 := ("111","010","001","101","000","101","011","000","000","101","011");
   constant ESTIMULO_CI : tabla2 := ("0"  ,"0"  ,"0"  ,"1"  ,"0"  ,"1"  ,"0"  ,"1"  ,"1"  ,"0"  ,"1"  );
   constant SUMA        : tabla1 := ("001","101","111","000","111","100","111","000","001","000","000");
   constant ACARREO     : tabla3 := ('1'  ,'0'  ,'0'  ,'1'  ,'0'  ,'1'  ,'0'  ,'1'  ,'0'  ,'1'  ,'1'  );	

begin
dut: SumMagN generic map(N     => 3) 
	     port    map(a_i   => a_t,
            		 b_i   => b_t, 
		         ci_i  => ci_t,
		         sum_o => su_t,
                         co_o  => co_t);
Prueba: 
   process begin	
      report "Verificando el sumador de magnitudes de 3 bits"
      severity note;

      for i in tabla1'range loop
         a_t  <= ESTIMULO_A(i);
         b_t  <= ESTIMULO_B(i);
         ci_t <= ESTIMULO_CI(i);
         wait for 1 ns;
         assert su_t = SUMA(i)
            report "Falla la suma para a="& integer'image(to_integer(unsigned(a_t)))
                   & " y b=" & integer'image(to_integer(unsigned(b_t)))
            severity failure;
         assert co_t = ACARREO(i)
            report "Falla el acarreo para a="& integer'image(to_integer(unsigned(a_t)))
                   & " y b=" & integer'image(to_integer(unsigned(b_t)))
            severity failure;
      end loop;		
	
      report "!Verificacion exitosa!"
      severity note;
      wait;
	
   end process Prueba;
end architecture Test;
--------------------------------------------------------------------------------------------------------
