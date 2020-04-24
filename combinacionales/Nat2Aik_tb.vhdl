-- 14.03.19 ---------------- Susana Canel ---------------- Nat2Aik_tb.vhdl
-- TESTBENCH DEL CONVERSOR DE BCD NATURAL A BCD AIKEN
library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------
entity Nat2Aik_tb is
end entity Nat2Aik_tb;
--------------------------------------------------------------------------
architecture Test of Nat2Aik_tb is
   ---------------------------------------------------
   component Nat2Aik is
      port(n_i	 : in  std_logic_vector(3 downto 0);
           a_o   : out std_logic_vector(3 downto 0));	
   end component Nat2Aik;
   ---------------------------------------------------
   signal n_t  : std_logic_vector(3 downto 0) := "0000";
   signal a_t  : std_logic_vector(3 downto 0);
   type tabla is array (0 to 9) of std_logic_vector( 3 downto 0);
   constant TABLA_AIKEN : tabla := ("0000", 
                                    "0001", 
                                    "0010", 
                                    "0011", 
                                    "0100",
	                            "1011", 
                                    "1100", 
                                    "1101", 
                                    "1110", 
                                    "1111");
begin
dut: Nat2Aik port map(n_i => n_t,
		      a_o => a_t);
Prueba:
   process begin
      report "Probando el conversor de BCD natural a BCD Aiken"
	 severity note;

      for i in tabla'range loop
         n_t <= std_logic_vector(to_unsigned(i, 4));
         wait for 1 ns;
         assert a_t = TABLA_AIKEN(i)
            report "Falla para "& integer'image(to_integer(unsigned(n_t)))
            severity failure;
      end loop;
 		 
      report "!Prueba exitosa!"
      severity note;
      wait;
   end process Prueba;
	
end architecture Test;
--------------------------------------------------------------------------