-- 29.08.19 -------- Susana Canel --------- ContMpot2TcQ_rs_en.vhdl
-- CONTADOR SINCRONICO, GENERICO, BINARIO, MODULO POTENCIA DE DOS,
-- CON RESET SINCRONICO Y HABILITACION.
-- SALIDAS: ESTADO Y CUENTA TERMINAL.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------
entity ContMpot2TcQ_rs_en is
   generic(N     : positive := 3);
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;
           ena_i : in  std_logic;
           q_o   : out std_logic_vector(N-1 downto 0);
           tc_o  : out std_logic);
end entity ContMpot2TcQ_rs_en;

-------------------------------------------------------------------
-- EJEMPLO: PARA N=3, CUENTA DESDE 000 A 111 (0 A 7) ==> MODULO M=8

architecture Arq of ContMpot2TcQ_rs_en is 
   signal auxQ  : unsigned (N-1 downto 0);
   constant M   : positive := 2**N;                 -- modulo               
begin
   Contador:
   process (clk_i) begin
      if rising_edge (clk_i) then
         if rst_i='1' then
            auxQ <= (others => '0');
         elsif ena_i='1' then
            auxQ <= auxQ + 1;	
         end if;
      end if;
   end process Contador;
   
   q_o  <= std_logic_vector(auxQ);  
   tc_o <= '1' when auxQ=M-1 else
           '0';	
           
end architecture Arq;
-------------------------------------------------------------------
