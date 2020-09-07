-- 06.09.20 --------------- Susana Canel --------------- SumadorSerie2_tb.vhdl
-- TESTBENCH DEL SUMADOR SERIE CON REGISTROS DE DESPLAZAMIENTO CON CARGA EN 
-- PARALELO, USADO PARA OBTENER LA SUMA DE LOS PRIMEROS "N" NUMEROS NATURALES.
library ieee;   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------------
entity SumadorSerie2_tb is 
end entity SumadorSerie2_tb;
------------------------------------------------------------------------------
architecture Test of SumadorSerie2_tb is
  ------------------------------------------------------
  component SumadorSerie2 is
    generic(N     : positive := 4);
      port (clk_i : in  std_logic;
            rst_i : in  std_logic;
            peA_i : in  std_logic;
            peB_i : in  std_logic;
            a_i   : in  std_logic_vector(N-1 downto 0);
            b_i   : in  std_logic_vector(N-1 downto 0);
            s_o   : out std_logic_vector(N-1 downto 0);
            led_o : out std_logic;
            c_o   : out std_logic);
  end component SumadorSerie2;
  ------------------------------------------------------
  signal   clk_t      : std_logic :='1';
  signal   rst_t      : std_logic :='1';
  signal   peA_t      : std_logic :='1';
  signal   peB_t      : std_logic :='1';
  signal   led_t      : std_logic;
  signal   c_t        : std_logic;
  constant BITS       : positive  := 7 ;
  signal   a_t        : std_logic_vector(BITS-1 downto 0) :=(others=>'0');
  signal   b_t        : std_logic_vector(BITS-1 downto 0) :=(others=>'0');
  signal   s_t        : std_logic_vector(BITS-1 downto 0);
  constant FRECUENCIA : integer := 50;              -- en MHz
  constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
  signal   detener    : boolean := false;	 	
begin
  dut: SumadorSerie2 generic map(N     => BITS)
                     port    map(clk_i => clk_t,
                                 rst_i => rst_t,
                                 peA_i => peA_t,
                                 peB_i => peB_t,
                                 a_i   => a_t,
                                 b_i   => b_t,
                                 s_o   => s_t,
                                 led_o => led_t,
                                 c_o   => c_t);
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
  rst_t <= '1' , '0' after PERIODO*3/2;

  Prueba:
  process begin
    report "Verificando la suma de los primeros 15 numeros naturales, 7 bits "
    severity note;
    
    wait until rst_t='0';
    wait for 3 ns;	                    -- tp
    ----------------------------------------- inicializa el registro auxA en 0
    a_t   <= (others=>'0');
    peA_t <='1';  
    wait for 3 ns;			              -- genera ts
    wait until rising_edge(clk_t);
    wait for 2 ns;			              -- genera th y tp
    peA_t <='0';  
    wait for 3 ns;		

    -------------------------------- suma de los 15 primeros numeros naturales
    ------------------------------------ valor maximo=120 en la suma de 7 bits
    for i in 1 to 15 loop                
      b_t   <= std_logic_vector(to_unsigned(i, BITS));
      peB_t <='1';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      peB_t <='0';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);        -- espera que se desplace 7 veces
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait for 2 ns;  
    end loop;

    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);

    wait for 2 ns; 
    detener <= true;
    wait;
  end process; 
                     								  
end architecture Test;
------------------------------------------------------------------------------