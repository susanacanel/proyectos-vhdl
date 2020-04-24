-- 05.04.19 ---------------------------- Susana Canel------------------------------- ParidadN_tb.vhdl
-- TESTBENCH DE UN ARBOL DE PARIDAD GENERICO, CON SALIDAS DE 
-- PARIDAD PAR E IMPAR

library ieee;     
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------------------------------------------------------
entity ParidadN_tb is
end entity ParidadN_tb;
-----------------------------------------------------------------------------------------------------
architecture Arq of ParidadN_tb is 
   -----------------------------------------------------
   component ParidadN is
      generic(N    : integer:=4);
      port   (a_i  : in  std_logic_vector(N-1 downto 0);
              pp_o : out std_logic;
              pi_o : out std_logic);
   end component ParidadN;
   -----------------------------------------------------
   signal a_t  : std_logic_vector(3 downto 0) := (others=>'0');
   signal pp_t : std_logic;
   signal pi_t : std_logic;
   type tabla is array (0 to 15) of std_logic;
   constant PARIDAD_PAR : tabla := ('1','0','0','1','0','1','1','0','0','1','1','0','1','0','0','1');
   constant PARIDAD_IMP : tabla := ('0','1','1','0','1','0','0','1','1','0','0','1','0','1','1','0');
begin
dut : ParidadN generic map(N    => 4)
               port    map(a_i  => a_t,
		           pp_o => pp_t,
		           pi_o => pi_t);
Prueba:
    process begin
      report "Verificando el arbol de paridad de 4 entradas"
      severity note;
   
      for i in tabla'range loop
         a_t <= std_logic_vector(to_unsigned(i,4));
         wait for 1 ns;
         assert pp_t=PARIDAD_PAR(i)
            report "Falla paridad par para a=" & integer'image(to_integer(unsigned(a_t)))
            severity failure;
         assert pi_t=PARIDAD_IMP(i)
            report "Falla paridad impar para a=" & integer'image(to_integer(unsigned(a_t)))
            severity failure;
      end loop;   

      report "¡Verificación exitosa!"
      severity note;
      wait;  
   end process Prueba;                      
end architecture Arq;
-----------------------------------------------------------------------------------------------------
