-- 16.10.18 -------------- Susana Canel ------------ AND2ecu_tb.vhdl
library ieee;
use ieee.std_logic_1164.all;

--------------------------------------------------------------------
entity AND2ecu_tb is
end entity AND2ecu_tb;
--------------------------------------------------------------------
architecture Test of AND2ecu_tb is
        --------------------------------------------------
	component AND2ecu is
		port (a_i   :  in std_logic;
	      	      b_i   :  in std_logic;
	      	      y_o   : out std_logic   );
	end component AND2ecu;
        -------------------------------------------------
	signal a_t : std_logic := '0';
	signal b_t : std_logic := '0';
	signal y_t : std_logic;
begin
dut: AND2ecu port map(a_i => a_t,
                      b_i => b_t,
                      y_o => y_t);
Prueba:
	process begin
		report "Verificando la compuerta AND de 2 entradas"
		severity note;

		a_t <= '0';
		b_t <= '0';
		wait for 1 ns;
		assert y_t='0'
			report "Falla para a_i='0' y b_i='0'"
			severity failure;

		a_t <= '1';
		b_t <= '0';
		wait for 1 ns;
		assert y_t='0'
			report "Falla para a_i='1' y b_i='0'"
			severity failure;

		a_t <= '0';
		b_t <= '1';
		wait for 1 ns;
		assert y_t='0'
			report "Falla para a_i='0' y b_i='1'"
			severity failure;

		a_t <= '1';
		b_t <= '1';
		wait for 1 ns;
		assert y_t='1'
			report "Falla para a_i='1' y b_i='1'"
			severity failure;

		a_t <= '0';
		b_t <= '0';
		wait for 1 ns;
		assert y_t='0'
			report "Falla para a_i='0' y b_i='0'"
			severity failure;

		report "Verificacion exitosa!"
                severity note;
		wait;
   	end process Prueba;
end architecture Test;
---------------------------------------------------------------------

