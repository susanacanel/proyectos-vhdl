-- 07.08.20 ----------- Susana Canel ----------- DivisorFrec_tb.vhdl
-- TESTBENCH DEL DIVISOR DE FRECUENCIA.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------------
entity DivisorFrec_tb is 
end entity DivisorFrec_tb;
---------------------------------------------------------------------
architecture Test of DivisorFrec_tb is
  ------------------------------------------------------
  component DivisorFrec is
    port (clk_i : in  std_logic;
          clr_i : in  std_logic;
          clk_o : out std_logic);
  end component DivisorFrec;
  ------------------------------------------------------
  signal   clk_t      : std_logic :='1';
  signal   clr_t      : std_logic :='1';
  signal   clko_t     : std_logic;
  constant FRECUENCIA : integer := 24;              -- en MHz
  constant PERIODO    : time    := 1 us/FRECUENCIA; -- 41,66 ns
  signal   detener    : boolean := false;	 	
begin
  dut: DivisorFrec port map(clk_i => clk_t,
                            clr_i => clr_t,
                            clK_o => clko_t);
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

  clr_t <= '1' , '0' after PERIODO*3/2;

  Prueba:
  process begin
    report "Verificando el Divisor de frecuencia de 24MHz a 1MHz"
    severity note;
    
    wait until clr_t='0';
    wait for 3 ns;	

    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);         
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);

    detener <= true;
    wait;
  end process; 
                     								  
end architecture Test;
---------------------------------------------------------------------