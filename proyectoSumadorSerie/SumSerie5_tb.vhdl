-- 28.10.20 ----------------- Susana Canel ---------------- sumSerie5_tb.vhdl
-- TESTBENCH DEL SUMADOR SERIE CON CARGA EN PARALELO. AVISA FIN DE SUMA Y LA 
-- MUESTRA.
library ieee;   
use ieee.std_logic_1164.all;
-----------------------------------------------------------------------------
entity sumSerie5_tb is 
end entity sumSerie5_tb;
-----------------------------------------------------------------------------
architecture Test of sumSerie5_tb is
  ------------------------------------------------------
  component sumSerie5 is
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
  end component sumSerie5;
  ------------------------------------------------------
  signal   clk_t         : std_logic :='1';
  signal   rst_t         : std_logic :='1';
  signal   pe_t          : std_logic :='0';
  signal   a_t           : std_logic_vector(3 downto 0) :=(others=>'0');
  signal   b_t           : std_logic_vector(3 downto 0) :=(others=>'0');
  signal   suma_t        : std_logic_vector(3 downto 0);
  signal   sal_t         : std_logic_vector(3 downto 0);
  signal   ledSuma_t     : std_logic;
  signal   ledError_t    : std_logic;
  signal   ledAcarreo_t  : std_logic;
  constant FRECUENCIA    : integer := 50;              -- en MHz
  constant PERIODO       : time    := 1 us/FRECUENCIA; -- en ns
  signal   detener       : boolean := false;	 	
begin
  dut: sumSerie5 generic map(N            => 4)
                 port    map(clk_i        => clk_t,
                             rst_i        => rst_t,
                             pe_i         => pe_t,
                             a_i          => a_t,
                             b_i          => b_t,
                             suma_o       => suma_t,
                             a_o          => sal_t,
                             ledSuma_o    => ledSuma_t,
                             ledError_o   => ledError_t,
                             ledAcarreo_o => ledAcarreo_t);
  -------------------------------------
  GeneraReloj:						  
  process begin 	
    clk_t <= '1', '0' after PERIODO/2;
    wait for PERIODO;
    if detener then
       wait;
    end if;
  end process GeneraReloj;
  -------------------------------------
  rst_t <= '1' , '0' after PERIODO*3/2, '1' after 1360 ns, '0' after 1375 ns;

  Prueba:
  process begin
    report "Verificando el sumador serie de 4 bits con fin de cuenta"
    severity note;

    wait until rst_t='0';
    wait for 3 ns;    

    pe_t <='0';  
    wait for 3 ns;

    a_t  <= "0011";
    b_t  <= "0010";
    ------------------------------------------- carga paralelo activa
    pe_t <='1';  
    wait for 3 ns;			              -- genera ts
    wait until rising_edge(clk_t);
    wait for 2 ns;			              -- genera th y tp
    ----------------------------------------- carga paralelo inactiva
    pe_t <='0';  
    wait for 140 ns;			              

    a_t  <= "0111";
    b_t  <= "1001";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;
    pe_t <='0';  
    wait for 140 ns;

    a_t  <= "0111";
    b_t  <= "0010";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 140 ns;

    a_t  <= "0010";
    b_t  <= "0111";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 140 ns;			              		              

    a_t  <= "0011";
    b_t  <= "0110";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 155 ns;

    a_t  <= "0110";
    b_t  <= "0011";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 140 ns;

    a_t  <= "1000";
    b_t  <= "1001";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 140 ns;

    a_t  <= "1001";
    b_t  <= "1000";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 140 ns;

    a_t  <= "0101";
    b_t  <= "1101";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 140 ns;			              

    a_t  <= "0110";
    b_t  <= "0001";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 160 ns;			              

    a_t  <= "1001";
    b_t  <= "0111";
    pe_t <='1';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    pe_t <='0';  
    wait for 155 ns;

      a_t  <= "1000";
      b_t  <= "0100";
      pe_t <='1';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      pe_t <='0';  
      wait for 140 ns;			              

      a_t  <= "1010";
      b_t  <= "0111";
      pe_t <='1';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      pe_t <='0';  
      wait for 155 ns;			              
          
    detener <= true;
    wait;
  end process; 
                     								  
end architecture Test;
-----------------------------------------------------------------------------
