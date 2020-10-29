-- 28.10.20 ------------------------ Susana Canel -------------------------- sumSerie5.vhdl 
-- SUMADOR SERIE, CON REGISTROS DE DESPLAZAMIENTO CON CARGA EN PARALELO. AVISA FIN DE SUMA.
library ieee;   
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
------------------------------------------------------
entity sumSerie5 is
   generic(N              : positive := 4);
   port   (clk_i          : in  std_logic;
           rst_i          : in  std_logic;   
           pe_i           : in  std_logic;
           a_i            : in  std_logic_vector(N-1 downto 0);
           b_i            : in  std_logic_vector(N-1 downto 0);
           suma_o         : out std_logic_vector(N-1 downto 0);
           a_o            : out std_logic_vector(N-1 downto 0);           
           ledSuma_o      : out std_logic;
           ledError_o     : out std_logic;           
           ledAcarreo_o   : out std_logic);
end entity sumSerie5;
------------------------------------------------------
architecture Arq of sumSerie5 is
  type   estado is (inicial, cargaRegistros, esperaLiberacion, desplaza, muestraSuma);
  signal proximo       : estado;  
  signal auxA, auxB    : std_logic_vector(N-1 downto 0);   
  signal a, b          : std_logic_vector(2 downto 0);
  signal sum           : unsigned(2 downto 0);
  signal ci            : std_logic;                        
  signal co            : std_logic;  
  signal cuentaDesplaz : unsigned(N-1 downto 0);
begin
  Registro: 
  process (clk_i, rst_i) is begin     -- reset asincronico
 
      if rst_i='1' then
        suma_o       <= (others=>'0');
        ledSuma_o    <= '0'; 
        ledError_o   <= '0';           
        ledAcarreo_o <= '0';   
        proximo      <= inicial;
        
      elsif rising_edge(clk_i) then

        case proximo is

          when inicial =>

                ci             <= '0';
                cuentaDesplaz  <= (others=>'0');        
                if pe_i='1' then
                  proximo <= cargaRegistros;
                else
                  proximo <= inicial;
                end if;

          when cargaRegistros =>  

                ledError_o    <= '0';  
                ledSuma_o     <= '0'; 
                ledAcarreo_o  <= '0';               
                suma_o        <= (others=>'0');
                proximo       <= esperaLiberacion;                              
                if a_i < "1010" then               -- no permite que el operando no sea BCD
                  auxA <= a_i;   
                else
                  ledError_o <= '1';
                  proximo    <= inicial;
                end if;           
                if b_i < "1010" then               -- no permite que el operando no sea BCD
                  auxB <= b_i;
                else
                  ledError_o <= '1';
                  proximo    <= inicial;
                end if;  

          when esperaLiberacion =>

                if pe_i='0' then
                  proximo <= desplaza;
                else
                  proximo <= esperaLiberacion;
                end if;
                  
          when desplaza =>
          
                auxA <= sum(1)  & auxA(N-1 downto 1);
                auxB <= auxB(0) & auxB(N-1 downto 1);
                ci   <= co;
                if cuentaDesplaz<N-1 then
                  cuentaDesplaz <= cuentaDesplaz + 1;   
                  proximo       <= desplaza;
                else
                  cuentaDesplaz <= (others=>'0'); 
                  ledAcarreo_o  <= co;         
				          proximo       <= muestraSuma;                 
                end if;   

           when muestraSuma =>

                 suma_o     <= auxA;             
                 ledSuma_o  <= '1';
                 proximo    <= inicial;
  
        end case;
      end if; 
  end process Registro;	

  -- acondicionamiento de los operandos para la proxima suma
  a   <= '0' & auxA(0) & ci;
  b   <= '0' & auxB(0) & '1';
  
  sum <= unsigned(a) + unsigned(b); 
  co  <= sum(2);
  
  a_o <= auxA;
                                             
end architecture Arq;
-------------------------------------------------------------------------------------------
