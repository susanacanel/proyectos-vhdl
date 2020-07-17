-- 16.07.20 ----------- Susana Canel ----------- SumadorSerie_tb.vhdl
-- TESTBENCH DEL SUMADOR SERIE CON CARGA EN PARALELO.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------
entity SumadorSerie_tb is 
end entity SumadorSerie_tb;
---------------------------------------------------------------------
architecture Test of SumadorSerie_tb is
  ------------------------------------------------------
  component SumadorSerie is
    generic(N     : positive := 4);
    port   (clk_i : in  std_logic;
            pe_i  : in  std_logic;
            a_i   : in  std_logic_vector(N-1 downto 0);
            b_i   : in  std_logic_vector(N-1 downto 0);
            s_o   : out std_logic_vector(N-1 downto 0);
            c_o   : out std_logic);
  end component SumadorSerie;
  ------------------------------------------------------
  signal clk_t        : std_logic :='1';
  signal pe_t         : std_logic :='1';
  signal a_t          : std_logic_vector(3 downto 0) :=(others=>'0');
  signal b_t          : std_logic_vector(3 downto 0) :=(others=>'0');
  signal s_t          : std_logic_vector(3 downto 0);
  signal c_t          : std_logic;
  constant FRECUENCIA : integer := 50;              -- en MHz
  constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
  signal detener      : boolean := false;	 	
begin
  dut: SumadorSerie generic map(N     => 4)
                    port    map(clk_i => clk_t,
                                pe_i  => pe_t,
                                a_i   => a_t,
                                b_i   => b_t,
                                s_o   => s_t,
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
  Prueba:
  process begin
    report "Verificando el sumador serie de 4 bits"
    severity note;
		
    a_t  <= "0011";
    b_t  <= "0010";
    ------------------------------------------- carga paralelo activa
    pe_t <='1';  
    wait for 3 ns;			              -- genera ts
    wait until rising_edge(clk_t);
    wait for 2 ns;			              -- genera th y tp
    ----------------------------------------- carga paralelo inactiva
    pe_t <='0';  
    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    assert s_t="0101"
      report "Falla s para a=0011, b=0010" 
      severity failure;
    assert c_t='0'
      report "Falla c para a=0011, b=0010" 
      severity failure;

      a_t  <= "0111";
      b_t  <= "1001";
      ----------------------------------------- carga paralelo activa
      pe_t <='1';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      --------------------------------------- carga paralelo inactiva
      pe_t <='0';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      assert s_t="0000"
        report "Falla s para a=0111, b=1001" 
        severity failure;
      assert c_t='1'
        report "Falla c para a=0111, b=1001" 
        severity failure;      
	
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process; 
                     								  
end architecture Test;
---------------------------------------------------------------------