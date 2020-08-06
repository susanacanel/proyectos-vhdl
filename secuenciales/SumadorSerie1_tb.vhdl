-- 06.08.20 ----------- Susana Canel ----------- SumadorSerie1_tb.vhdl
-- TESTBENCH DEL SUMADOR SERIE CON CARGA EN PARALELO. AVISA FIN DE 
-- SUMA Y LA MUESTRA.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------
entity SumadorSerie1_tb is 
end entity SumadorSerie1_tb;
---------------------------------------------------------------------
architecture Test of SumadorSerie1_tb is
  ------------------------------------------------------
  component SumadorSerie1 is
    generic(N     : positive := 4);
    port   (clk_i : in  std_logic;
            pe_i  : in  std_logic;
            a_i   : in  std_logic_vector(N-1 downto 0);
            b_i   : in  std_logic_vector(N-1 downto 0);
            s_o   : out std_logic_vector(N-1 downto 0);
            led_o : out std_logic;
            c_o   : out std_logic);
  end component SumadorSerie1;
  ------------------------------------------------------
  signal   clk_t      : std_logic :='1';
  signal   pe_t       : std_logic :='1';
  signal   a_t        : std_logic_vector(3 downto 0) :=(others=>'0');
  signal   b_t        : std_logic_vector(3 downto 0) :=(others=>'0');
  signal   s_t        : std_logic_vector(3 downto 0);
  signal   led_t      : std_logic;
  signal   c_t        : std_logic;
  constant FRECUENCIA : integer := 50;              -- en MHz
  constant PERIODO    : time    := 1 us/FRECUENCIA; -- en ns
  signal   detener    : boolean := false;	 	
begin
  dut: SumadorSerie1 generic map(N     => 4)
                     port    map(clk_i => clk_t,
                                 pe_i  => pe_t,
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
  Prueba:
  process begin
    report "Verificando el sumador serie de 4 bits con fin de cuenta"
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
    assert led_t='0'
      report "Falla el led para a=0011, b=0010, cuando esta sumando" 
      severity failure;
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait for 2 ns;			              
    assert s_t="0101"
      report "Falla la suma para a=0011, b=0010, cuando esta sumando" 
      severity failure;
    assert c_t='0'
      report "Falla el acarreo para a=0011, b=0010, cuando esta sumando" 
      severity failure;
    assert led_t='1'
      report "Falla el led para a=0011, b=0010, cuando esta sumando" 
      severity failure;
    --------------------------------------- carga paralelo inactiva
    a_t  <= "0111";
    b_t  <= "1001";

    wait for 3 ns;			              
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait for 2 ns;
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
      report "Falla la suma para a=0111, b=1001, cuando esta sumando" 
      severity failure;
    assert c_t='1'
      report "Falla el acarreo para a=0111, b=1001, cuando esta sumando" 
      severity failure;      
      assert led_t='1'
      report "Falla el led para a=0111, b=1001, cuando esta sumando" 
      severity failure;

      a_t  <= "0101";
      b_t  <= "1101";
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
      assert led_t='0'
        report "Falla el led para a=0101, b=1101, cuando esta sumando" 
        severity failure;
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      assert s_t="0010"
        report "Falla la suma para a=0101, b=1101, cuando esta sumando" 
        severity failure;
      assert c_t='1'
        report "Falla el acarreo para a=0101, b=1101, cuando esta sumando" 
        severity failure;
      assert led_t='1'
        report "Falla el led para a=0101, b=1101, cuando esta sumando" 
        severity failure;

      a_t  <= "0110";
      b_t  <= "0001";
      ------------------------------------------- carga paralelo activa
      pe_t <='1';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      ----------------------------------------- carga paralelo inactiva
      pe_t <='0';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      assert led_t='0'
        report "Falla el led para a=0110, b=0001, cuando esta sumando" 
        severity failure;
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      assert s_t="0111"
        report "Falla la suma para a=0110, b=0001, cuando esta sumando" 
        severity failure;
      assert c_t='0'
        report "Falla el acarreo para a=0110, b=0001, cuando esta sumando" 
        severity failure;
      assert led_t='1'
        report "Falla el led para a=0110, b=0001, cuando esta sumando" 
        severity failure;
  
        a_t  <= "1000";
        b_t  <= "0100";
        ------------------------------------------- carga paralelo activa
        pe_t <='1';  
        wait for 3 ns;			              
        wait until rising_edge(clk_t);
        wait for 2 ns;			              
        ----------------------------------------- carga paralelo inactiva
        pe_t <='0';  
        wait for 3 ns;			              
        wait until rising_edge(clk_t);
        wait until rising_edge(clk_t);
        assert led_t='0'
          report "Falla el led para a=1000, b=0100, cuando esta sumando" 
          severity failure;
        wait until rising_edge(clk_t);
        wait until rising_edge(clk_t);
        wait for 2 ns;			              
        assert s_t="1100"
          report "Falla la suma para a=1000, b=0100, cuando esta sumando" 
          severity failure;
        assert c_t='0'
          report "Falla el acarreo para a=1000, b=0100, cuando esta sumando" 
          severity failure;
        assert led_t='1'
          report "Falla el led para a=1000, b=0100, cuando esta sumando" 
          severity failure;

          a_t  <= "1010";
          b_t  <= "0111";
          ------------------------------------------- carga paralelo activa
          pe_t <='1';  
          wait for 3 ns;			              
          wait until rising_edge(clk_t);
          wait for 2 ns;			              
          ----------------------------------------- carga paralelo inactiva
          pe_t <='0';  
          wait for 3 ns;			              
          wait until rising_edge(clk_t);
          wait until rising_edge(clk_t);
          assert led_t='0'
            report "Falla el led para a=1010, b=0111, cuando esta sumando" 
            severity failure;
          wait until rising_edge(clk_t);
          wait until rising_edge(clk_t);
          wait for 2 ns;			              
          assert s_t="0001"
            report "Falla la suma para a=1010, b=0111, cuando esta sumando" 
            severity failure;
          assert c_t='1'
            report "Falla el acarreo para a=1010, b=0111, cuando esta sumando" 
            severity failure;
          assert led_t='1'
            report "Falla el led para a=1010, b=0111, cuando esta sumando" 
            severity failure;
            
      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process; 
                     								  
end architecture Test;
---------------------------------------------------------------------