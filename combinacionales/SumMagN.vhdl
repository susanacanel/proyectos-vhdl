-- 24.08.18 -------------- Susana Canel -------------- SumMagN.vhdl
-- SUMADOR BINARIO GENERICO, DE MAGNITUDES DE N BITS

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

------------------------------------------------------------------
entity SumMagN is
	generic(N  : positive := 3); 
	port(a_i   :  in std_logic_vector(N-1 downto 0);
             b_i   :  in std_logic_vector(N-1 downto 0);
             ci_i  :  in std_logic_vector(0 downto 0);   
             sum_o : out std_logic_vector(N-1 downto 0);
             co_o  : out std_logic
             );
end entity SumMagN;

------------------------------------------------------------------
architecture Arq of SumMagN is 
	signal auxSum : unsigned(N downto 0);
begin

	auxSum <= '0' & unsigned(a_i) + unsigned(b_i) + unsigned(ci_i);
	
	sum_o  <= std_logic_vector(auxSum(N-1 downto 0));
	co_o   <= auxSum(N);
	
end architecture Arq;
------------------------------------------------------------------
