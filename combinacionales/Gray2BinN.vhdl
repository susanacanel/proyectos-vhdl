-- 23.08.18 ------------ Susana Canel ------------- Gray2BinN.vhdl
-- CONVERSOR GENERICO DE CODIGO GRAY A BINARIO NATURAL, N BITS

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------
entity Gray2BinN is
   generic(N  : integer := 4);
   port(g_i   :  in std_logic_vector(N-1 downto 0);
        b_o   : out std_logic_vector(N-1 downto 0)
        );
end entity Gray2BinN;
------------------------------------------------------------------
-- DESCRIPCION USANDO LA OPERACION XOR ENTRE VECTORES

architecture Comportamiento of Gray2BinN is
   
	signal baux : std_logic_vector(N-1 downto 0);
   
begin
	baux(N-1)          <= g_i(N-1);
	baux(N-2 downto 0) <= baux(N-1 downto 1) xor g_i(N-2 downto 0);
	
	b_o                <= baux;
	
end architecture Comportamiento;
------------------------------------------------------------------
