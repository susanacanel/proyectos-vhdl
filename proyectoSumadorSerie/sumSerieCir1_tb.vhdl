-- 21.10.20 --------------------------------- Susana Canel -------------------------------sumSerieCir1_tb.vhdl
-- TESTBENCH DEL DIVISOR DE FRECUENCIA Y EL ANTIRREBOTE. 
library ieee;   
use ieee.std_logic_1164.all;
--------------------------------------------------------------------------------------------------------------
entity sumSerieCir1_tb is 
end entity sumSerieCir1_tb;
--------------------------------------------------------------------------------------------------------------
architecture Test of sumSerieCir1_tb is
  ---------------------------------------
  component sumSerieCir1 is
    port   (clk_i      : in  std_logic;
            rst_i      : in  std_logic;   
            boton_i    : in  std_logic;           
            led1s_o    : out std_logic;           
            ledVal_o   : out std_logic );
 end component sumSerieCir1;
  ---------------------------------------
  signal   clk_t      : std_logic :='1';
  signal   rst_t      : std_logic :='1';
  signal   boton_t    : std_logic :='0';
  signal   valido_t   : std_logic;
  signal   led1s_t    : std_logic;
  signal   ledVal_t   : std_logic;
  constant FRECUENCIA : integer := 24;              -- en MHz
  constant PERIODO    : time    := 1 us/FRECUENCIA; -- 41,66 ns
  signal   detener    : boolean := false;	 	
begin
  dut: sumSerieCir1 port map (clk_i    => clk_t,
                              rst_i    => rst_t,
                              boton_i  => boton_t,
                              led1s_o  => led1s_t,           
                              ledVal_o => ledVal_t);
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

  rst_t <= '1' , '0' after PERIODO*3/2, '1' after 95 ms, '0' after 110 ms, '1' after 170 ms, '0' after 185 ms;

  Prueba:
  process begin
    report "Verificando el divisor de frecuencia junto con el antirrebote"
    severity note;
    
    wait until rst_t='0';
    wait for 3 ns;	

    boton_t <= '1';
    wait for 5 ms;    

    boton_t <= '0';                   -- supongamos que rebota
    wait for 5 ms;    	

    boton_t <= '1';
    wait for 7 ms;	              

    boton_t <= '0';                 
    wait for 4 ms;              

    boton_t <= '1';                 
    wait for 5 ms;		                    

    boton_t <= '0';                 
    wait for 20 ms;                

    boton_t <= '1';
    wait for 15 ms;

    boton_t <= '0';                   
    wait for 10 ms;

    boton_t <= '1';
    wait for 10 ms;		                

    boton_t <= '0';               
    wait for 10 ms;	                

    boton_t <= '1';                 
    wait for 40 ms;	                	    

    boton_t <= '0';                 
    wait for 10 ms;	    
    
    boton_t <= '1';                 
    wait for 10 ms;	    
    
    boton_t <= '0';                 
    wait for 10 ms;	    
    
    boton_t <= '1';                 
    wait for 35 ms;	    
    
    boton_t <= '0';                 
    wait for 10 ms;		    
    
    boton_t <= '1';                 
    wait for 30 ms;	    
    
    boton_t <= '0';                 
    wait for 30 ms;	    

    boton_t <= '1';                 
    wait for 30 ms;	    	    	    
    
    boton_t <= '0';                 
    wait for 25 ms;	    
    
    boton_t <= '1';                 
    wait for 25 ms;	    
    
    boton_t <= '0';                 
    wait for 10 ms;	    
		    
    boton_t <= '1';                 
    wait for 25 ms;	    	    
    
    boton_t <= '1';                 
    wait for 10 ms;	    	

    detener <= true;
    wait;
  end process; 
                     								  
end architecture Test;
--------------------------------------------------------------------------------------------------------------
