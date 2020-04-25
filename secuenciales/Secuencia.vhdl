-- 09.11.19 ----------- Susana Canel ----------- Secuencia.vhdl
-- GENERADOR DE SECUENCIA PSEUDO-ALEATORIA DE 5 BITS. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
---------------------------------------------------------------
entity Secuencia is
   generic(N     : positive:=5);     
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;
           so_o  : out std_logic;
           q_o   : out std_logic_vector(N-1 downto 0));
end entity Secuencia;
---------------------------------------------------------------
architecture Arq of Secuencia is
   signal si   : std_logic;
   signal auxQ : std_logic_vector(N-1 downto 0);
begin
   Genera: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' or unsigned(auxQ)=1 then --auxQ=1(5 bits)
            auxQ <= (others => '0');
         else
            auxQ <= si & auxQ(N-1 downto 1);
         end if;
      end if;
   end process Genera;
   
   q_o  <= auxQ;
   so_o <= auxQ(0);
   si   <= '1' when unsigned(auxQ)=0 else
           auxQ(2) xor auxQ(0);              -- xor válida
                                             -- para 5 bts
end architecture Arq;
---------------------------------------------------------------
-- ESTE ALGORITMO PARA 5 BITS DEBE ADAPTARSE PARA OTRA 
-- CANTIDAD DE BITS (VEA LA TABLA DE BITS A REALIMENTAR)
-- Y ANALIZAR CUAL ES EL ULTIMO ESTADO DE LA SECUENCIA
-- PARA GENERAR EL ESTADO TODOS LOS BITS EN 0.
