-- 01.04.19 ---------------------- Susana Canel ------------------------- DecoN_tb.vhdl
-- TESTBENCH DE UN DECODIFICADOR GENERICO CON HABILITACION.
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
---------------------------------------------------------------------------------------
entity DecoN_tb is
end entity DecoN_tb;
---------------------------------------------------------------------------------------
architecture Test of DecoN_tb is 
   ----------------------------------------------------------
   component DecoN is
      generic(N     : positive :=3); 
      port   (a_i   : in  std_logic_vector(N-1    downto 0); 
              ena_i : in  std_logic;
              y_o   : out std_logic_vector(2**N-1 downto 0)); 
   end component DecoN;
   ----------------------------------------------------------
   signal a_t   : std_logic_vector(1 downto 0) := (others=>'0');  
   signal ena_t : std_logic := '0';
   signal y_t   : std_logic_vector(3 downto 0); 
begin 
dut : DecoN generic map (N     => 2)
	    port    map (a_i   => a_t,
	                 ena_i => ena_t,
	                 y_o   => y_t);
Prueba:
   process begin
      report "Verificando un deco de 2 a 4"
      severity note;
 
      ena_t <= '1';  ----------------------------------------------------- HABILITADO
      for i in 0 to 3 loop
         a_t   <= std_logic_vector(to_unsigned(i,2));
         wait for 1 ns;
         assert to_integer(unsigned(y_t))= 2**i
            report "Falla para ena=1 y a=" & integer'image(to_integer(unsigned((a_t))))
            severity failure;
      end loop;

      ena_t <= '0';  ----------------------------------------------------- INHABILITADO
      for i in 0 to 3 loop
         a_t   <= std_logic_vector(to_unsigned(i,2));
         wait for 1 ns;
         assert y_t= "0000"
            report "Falla para ena=0 y a=" & integer'image(to_integer(unsigned((a_t))))
            severity failure;
      end loop;

      report "¡Verificación exitosa!"
      severity note;
      wait;
   end process Prueba;                      			 
end architecture Test;
---------------------------------------------------------------------------------------
