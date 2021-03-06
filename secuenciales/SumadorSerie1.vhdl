-- 06.08.20 ----- Susana Canel ----- SumadorSerie1.vhdl
-- SUMADOR SERIE CON REGISTROS DE DESPLAZAMIENTO CON 
-- CARGA EN PARALELO. AVISA FIN DE SUMA Y LA MUESTRA.

library ieee;   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------
entity SumadorSerie1 is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic;
           pe_i  : in  std_logic;
           a_i   : in  std_logic_vector(N-1 downto 0);
           b_i   : in  std_logic_vector(N-1 downto 0);
           s_o   : out std_logic_vector(N-1 downto 0);
           led_o : out std_logic;
           c_o   : out std_logic);
end entity SumadorSerie1;
------------------------------------------------------
architecture Arq of SumadorSerie1 is
  signal auxA, auxB : std_logic_vector(N-1 downto 0);   
  signal a, b       : std_logic_vector(2 downto 0);
  signal sum        : unsigned(2 downto 0);
  signal ci         : std_logic;                        
  signal co         : std_logic;  
  signal cuenta     : unsigned(N-1 downto 0);
  signal detener    : std_logic; 
begin
  Registro: 
  process (clk_i) is begin
    if rising_edge(clk_i) then
      if pe_i='1' then
        auxA    <= a_i;   
        auxB    <= b_i;
        ci      <= '0';
        cuenta  <= (others=>'0');
        c_o     <= '0';
        led_o   <= '0';
        detener <= '0';
      elsif detener='0' then
        auxA   <= sum(1)  & auxA(N-1 downto 1);
        auxB   <= auxB(0) & auxB(N-1 downto 1);
        ci     <= co;
        cuenta <= cuenta + 1;
        if cuenta=N-1 then
          c_o     <= co;
          led_o   <= '1';
          detener <= '1';
        end if;
      end if; 
    end if;
  end process Registro;	

  -- acondicionamiento de los operandos a sumar
  a   <= '0' & auxA(0) & ci;
  b   <= '0' & auxB(0) & '1';
  
  sum <= unsigned(a) + unsigned(b); 
  co  <= sum(2);
                                              
  s_o   <= auxA;

end architecture Arq;
------------------------------------------------------