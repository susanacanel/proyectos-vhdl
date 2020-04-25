-- 04.11.19 ------ Susana Canel ----- RegSISO_rst.vhdl
-- REGISTRO SISO Y SIPO, CARGA PARALELO, GENERICO,    
-- DE DESPLAZAMIENTO A DERECHA, CON RESET SINCRONICO.

library ieee;   
use ieee.std_logic_1164.all;
------------------------------------------------------
entity RegSISO_rst is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;
           pe_i  : in  std_logic;
           si_i  : in  std_logic;
           d_i   : in  std_logic_vector(N-1 downto 0);
           q_o   : out std_logic_vector(N-1 downto 0);
           so_o  : out std_logic);
end entity RegSISO_rst;
------------------------------------------------------
architecture Arq of RegSISO_rst is
   signal auxQ : std_logic_vector(N-1 downto 0);
begin
   Registro: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' then
            auxQ <= (others => '0');
         elsif pe_i='1' then
            auxQ <= d_i;   
         else
            auxQ <= si_i & auxQ(N-1 downto 1);
         end if;
      end if;
   end process Registro;
   
   q_o  <= auxQ;
   so_o <= auxQ(0);
	
end architecture Arq;
------------------------------------------------------
