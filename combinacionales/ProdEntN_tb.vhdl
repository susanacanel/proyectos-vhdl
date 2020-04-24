-- 29.03.19 --------------------- Susana Canel -------------------------------- ProdEntN_tb.vhdl
-- TESTBENCH DEL PRODUCTO DE ENTEROS DE N BITS

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------------------------------
entity ProdEntN_tb is
end entity ProdEntN_tb;
------------------------------------------------------------------------------------------------
architecture Test of ProdEntN_tb is 
   ------------------------------------------------------
   component ProdEntN is
      generic(N    : positive  := 3);
      port   (a_i  : in  std_logic_vector(N-1   downto 0);
	      b_i  : in  std_logic_vector(N-1   downto 0);
	      p_o  : out std_logic_vector(2*N-1 downto 0)  
	      );
   end component ProdEntN;
   -------------------------------------------------------
   signal a_t : std_logic_vector(2 downto 0) := (others=>'0');
   signal b_t : std_logic_vector(2 downto 0) := (others=>'0');
   signal p_t : std_logic_vector(5 downto 0);

begin
dut: ProdEntN generic map(N   => 3)
              port    map(a_i => a_t,
		          b_i => b_t,
		          p_o => p_t);
Prueba: 
   process begin
      report "Verificando el multiplicador de enteros, 3 bits"
      severity note;
			
      for i in -4 to 3 loop			 
	 a_t  <= std_logic_vector(to_signed(i,3));
         for j in -4 to 3 loop
	   b_t  <= std_logic_vector(to_signed(j,3));
	   wait for 1 ns;
	   assert to_integer(signed(p_t)) = i*j
	      report "El producto es erroneo, para a=" & integer'image(to_integer(signed((a_t))))
                     & " y b= " & integer'image(to_integer(signed((b_t))))
	      severity failure;	
         end loop;
      end loop;	
		
      report "!Verificacion exitosa!"
      severity note;
      wait;	
   end process Prueba;
end architecture Test;
------------------------------------------------------------------------------------------------
