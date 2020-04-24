-- 02.04.19 --------------------------------------------- Susana Canel ------------------------------------------------------------ Circuito_tb.vhdl
-- TESTBENCH DEL CIRCUITO DESCRIPTO EN FORMA ESTRUCTURAL

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------------------------------------------------------------------------------------------
entity Circuito_tb is
end entity Circuito_tb;
----------------------------------------------------------------------------------------------------------------------------------------------------
architecture Test of Circuito_tb is 
   ----------------------------------------------------
   component Circuito is
      port(a_i, b_i, c_i, d_i  :in  std_logic;
	   u_o, v_o	       :out std_logic);
   end component Circuito;
   ----------------------------------------------------
   signal a_t      : std_logic := '0'; 
   signal b_t      : std_logic := '0'; 
   signal c_t      : std_logic := '0'; 
   signal d_t      : std_logic := '0';
   signal u_t      : std_logic; 
   signal v_t      : std_logic;
   type tabla1 is array (0 to 15) of std_logic_vector(3 downto 0);
   type tabla2 is array (0 to 15) of std_logic;
   constant ESTIMULOS : tabla1 := ("0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111");
   constant TABLA_U   : tabla2 := ('1'   ,'1'   ,'1'   ,'0'   ,'1'   ,'1'   ,'1'   ,'0'   ,'1'   ,'1'   ,'1'   ,'0'   ,'1'   ,'1'   ,'1'   ,'0');
   constant TABLA_V   : tabla2 := ('1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'1'   ,'0'   ,'0'   ,'1'   ,'1');
begin
dut: Circuito port map(a_i => a_t,
                       b_i => b_t,
		       c_i => c_t,
		       d_i => d_t,
		       u_o => u_t,
		       v_o => v_t);
Prueba:
   process is begin
      report "Verificando del circuito"
      severity note;

      for i in tabla1'range loop
         a_t <= ESTIMULOS(i)(0);
         b_t <= ESTIMULOS(i)(1);
         c_t <= ESTIMULOS(i)(2);
         d_t <= ESTIMULOS(i)(3);
         wait for 1 ns;
         assert u_t=TABLA_U(i)
            report "Falla u para dcba = " & integer'image(i) 
            severity failure;
         assert v_t=TABLA_V(i)
            report "Falla v para dcba = " & integer'image(i) 
            severity failure;
      end loop;
	  
      report "¡Verificación exitosa!"
      severity note;
      wait;
   end process Prueba;                      
end architecture Test;
------------------------------------------------------------------------------------------------------------------------------------------------------
