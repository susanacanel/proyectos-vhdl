-- 17.10.19 ------ Susana Canel ------ RegSinc_ce_oe.vhdl
-- REGISTRO SINCRONICO, GENERICO, CON RESET, HABILITACION
-- DEL REGISTRO (ce) Y DE LA SALIDA DE 3 ESTADOS (oe).

library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------
entity RegSinc_ce_oe is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;	     
           ce_i  : in  std_logic;
           oe_i  : in  std_logic;
           d_i   : in  std_logic_vector(N-1 downto 0);
           q_o   : out std_logic_vector(N-1 downto 0));
end entity RegSinc_ce_oe;
---------------------------------------------------------
architecture Arq of RegSinc_ce_oe is
   signal auxQ : std_logic_vector(N-1 downto 0);
begin
   Registro: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' then
            auxQ <= (others => '0');
         elsif ce_i='1' then
            auxQ <= d_i;
         end if;
      end if;
   end process Registro;
	
   q_o <= auxQ when oe_i='1' else
         (others => 'Z');	
         
end architecture Arq;
---------------------------------------------------------

