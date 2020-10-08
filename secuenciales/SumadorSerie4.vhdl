-- 07.09.20 --------- Susana Canel -------- SumadorSerie4.vhdl 
-- SUMADOR SERIE CON REGISTROS DE DESPLAZAMIENTO CON CARGA
-- EN PARALELO. USADO PARA OBTENER LA TABLA DE MULTIPLICACION
-- DE UN NUMERO.

library ieee;   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------
entity SumadorSerie4 is
   generic(N     : positive := 4);
   port   (clk_i : in  std_logic;
           rst_i : in  std_logic;
           peA_i : in  std_logic;
           peB_i : in  std_logic;
           a_i   : in  std_logic_vector(N-1 downto 0);
           b_i   : in  std_logic_vector(N-1 downto 0);
           s_o   : out std_logic_vector(N-1 downto 0);
           led_o : out std_logic;
           c_o   : out std_logic);
end entity SumadorSerie4;
--------------------------------------------------------------
architecture Arq of SumadorSerie4 is
  signal auxA, auxB : std_logic_vector(N-1 downto 0);   
  signal a, b       : std_logic_vector(2 downto 0);
  signal sum        : unsigned(2 downto 0);
  signal cuenta     : unsigned(N-1 downto 0);
  signal ci         : std_logic;                        
  signal co         : std_logic; 
  signal exhibe     : std_logic;  
begin
  Registro: 
  process (clk_i) is begin
    if rising_edge(clk_i) then
      if rst_i='1' then
        cuenta  <= (others=>'0');        
        ci      <= '0';
        c_o     <= '0';
        led_o   <= '0';
      elsif peA_i='1' then
        auxA    <= a_i;
        exhibe  <= '0';
      elsif peB_i='1' then
        auxB    <= b_i;
        exhibe  <= '0';
      else
        auxA   <= sum(1)  & auxA(N-1 downto 1);
        auxB   <= auxB(0) & auxB(N-1 downto 1);
        ci     <= co;
        cuenta <= cuenta + 1;
        if cuenta=N-1 then
          c_o     <= co;
          led_o   <= '1';
          exhibe  <= '1';
          cuenta  <= (others=>'0');        
        end if;
      end if; 
    end if;
  end process Registro;	

  -- acondicionamiento de los operandos a sumar
  a <= '0' & auxA(0) & ci;
  b <= '0' & auxB(0) & '1';
  
  sum <= unsigned(a) + unsigned(b); 
  co  <= sum(2);
                 
  process (auxA) is begin
    if exhibe ='1' then
      s_o <= auxA;
    end if;  
  end process;

end architecture Arq;
--------------------------------------------------------------