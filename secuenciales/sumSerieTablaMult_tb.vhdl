-- 08.10.20 ----------------------------------- Susana Canel ---------------------------------------- sumSerieTablaMult_tb.vhdl
-- TESTBENCH DEL SUMADOR SERIE CON REGISTROS DE DESPLAZAMIENTO Y CARGA EN PARALELO. USADO PARA OBTENER LA TABLA DE 
-- MULTIPLICAR DEL 7. USA UN ARCHIVO PARA ESCRIBIR LA TABLA Y PROCEDIMIENTOS.
library ieee;   
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.package_escribe.all; 
---------------------------------------------------------------------------------------------------------------------------
entity sumSerieTablaMult_tb is 
end entity sumSerieTablaMult_tb;
---------------------------------------------------------------------------------------------------------------------------
architecture Test of sumSerieTablaMult_tb is
  ------------------------------------------------------
  component SumadorSerie4 is
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
  end component SumadorSerie4;
  ------------------------------------------------------
  signal   clk_t        : std_logic :='1';
  signal   rst_t        : std_logic :='1';
  signal   peA_t        : std_logic :='0';
  signal   peB_t        : std_logic :='0';
  signal   led_t        : std_logic;
  signal   c_t          : std_logic;
  constant BITS         : positive := 10;
  signal   a_t          : std_logic_vector(BITS-1 downto 0) :=(others=>'0');
  signal   b_t          : std_logic_vector(BITS-1 downto 0) :=(others=>'0');
  signal   s_t          : std_logic_vector(BITS-1 downto 0);
  file     outputhandle : text;
  constant FRECUENCIA   : integer := 50;              -- en MHz
  constant PERIODO      : time    := 1 us/FRECUENCIA; -- en ns
  signal   detener      : boolean := false;	 	
begin
  dut: SumadorSerie4 generic map(N     => BITS)
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
  process is
    variable numeroDeLinea : integer := 0;    
    variable numero        : integer;  
    variable multiplo      : integer;
  begin
    report "Verificando la tabla de multiplicacion del 7, usando el sumador serie de 10 bits"
    severity note;
    
    prepara_archivo ( outputhandle );

    wait until rst_t='0';
    wait for 3 ns;	                    -- tp
    ----------------------------------------------------------------------------------------- inicializo el registro auxA=0
    a_t   <= (others=>'0');
    peA_t <='1';  
    wait for 3 ns;			              -- genera ts
    wait until rising_edge(clk_t);
    wait for 2 ns;			              -- genera th y tp
    peA_t <='0';  
    wait for 3 ns;		
    ------------------------------------------------------------------------------- genero tabla de multiplicar hasta 7x100
    for i in 1 to 100 loop
      b_t   <= "0000000111";               
      peB_t <= '1';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);
      wait for 2 ns;			              
      peB_t <= '0';  
      wait for 3 ns;			              
      wait until rising_edge(clk_t);           -- espera que se desplace 10 bits
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait until rising_edge(clk_t);
      wait for 2 ns;  

      numero   := i;
      multiplo := numero * 7;
      escribe_tabla ( outputhandle, numero, multiplo); 

      numeroDeLinea := numeroDeLinea + 1;      
      assert to_integer( unsigned ( s_t) )= 7*i   
        report "Error en la linea "
        & integer'image ( numeroDeLinea )    
        & "Falla el producto de 7 por " 
        & integer'image( i ) 
        & " el valor es " 
        & integer'image( to_integer( unsigned( s_t ) ) )
        & " debería ser " 
        & integer'image( multiplo )
        severity failure;  
    end loop;
    -----------------------------------------------------------------------------------------------------------------------
    cierra_archivo ( outputhandle );

    report "Verificacion exitosa!"
    severity note;
    detener <= true;
    wait;
  end process; 
                     								  
end architecture Test;
---------------------------------------------------------------------------------------------------------------------------