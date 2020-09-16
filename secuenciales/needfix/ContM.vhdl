--- 24.09.19 --------- Susana Canel --------- ContM.vhdl
-- CONTADOR GENERICO, SINCRONICO, MODULO M, CON RESET Y 
-- HABILITACION. SALIDAS: ESTADO Y CUENTA TERMINAL.

library ieee;  
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------
entity ContM is
   generic(N      : positive := 4);
   port   (clk_i  : in  std_logic;
           rst_i  : in  std_logic;
           ena_i  : in  std_logic;
           tc_o   : out std_logic;
           q_o    : out std_logic_vector(N-1 downto 0));
end entity ContM;
--------------------------------------------------------
architecture Arq of ContM is 
   constant M   : integer :=10;
   signal auxQ  : unsigned(N-1 downto 0);
begin
   Contador: 
   process (clk_i) begin
      if rising_edge(clk_i) then
         if rst_i='1' then
            auxQ <= (others =>'0');
         elsif ena_i='1' then
            auxQ <= auxQ + 1;
            if auxQ=M-1 then
               auxQ <= (others =>'0');
            end if;
         end if;
      end if;
   end process contador;

   q_o  <= std_logic_vector(auxQ);	
   tc_o <= '1' when auxQ=M-1 else    -- genera warning
           '0';	                     -- metavalue en la
                                     -- simulacion
end architecture Arq;
--------------------------------------------------------