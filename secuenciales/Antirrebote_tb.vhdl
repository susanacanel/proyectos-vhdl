-- 28.08.20 ---------- Susana Canel --------Antirrebote_tb.vhdl
-- TESTBENCH DEL ANTIRREBOTE.
library ieee;   
use ieee.std_logic_1164.all;
---------------------------------------------------------------
entity Antirrebote_tb is 
end entity Antirrebote_tb;
---------------------------------------------------------------
architecture Test of Antirrebote_tb is
  ------------------------------------------------------
  component Antirrebote is
    generic(N       : positive := 4);
    port   (clk_i   : in  std_logic;
            rst_i   : in  std_logic;
            boton_i : in  std_logic;
            led_o   : out std_logic_vector(N-1 downto 0));
  end component Antirrebote;
  -------------------------------------------------------------
  signal   clk_t      : std_logic :='1';
  signal   rst_t      : std_logic :='1';
  signal   boton_t    : std_logic :='0';
  signal   led_t      : std_logic_vector(3 downto 0);
  constant FRECUENCIA : integer := 24;              -- en MHz
  constant PERIODO    : time    := 1 us/FRECUENCIA; -- 41,67 ns
  signal   detener    : boolean := false;	 	
begin
  dut: Antirrebote port map(clk_i   => clk_t,
                            rst_i   => rst_t,
                            boton_i => boton_t,
                            led_o   => led_t);
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
    report "Verificando el antirrebote"
    severity note;
    
    wait until rst_t='0';
    wait for 3 ns;	                   -- tp
    ---------------------------------------------- acciono el boton
    boton_t <= '1';
    wait for 3 ns;	                   -- tp y ts	
    wait until rising_edge(clk_t);     -- 0 clk
    wait for 2 ns;	
    assert led_t="0000"
      report "Fallo el led para 0000"
      severity failure;

    boton_t <= '0';                   -- supongamos que rebota
    wait for 3 ns;    
    wait until rising_edge(clk_t);    -- 1 clk
    wait for 2 ns;	                  	

    boton_t <= '1';                   -- sigue rebotando
    wait for 3 ns;
    wait until rising_edge(clk_t);    --  2 clk
    wait for 2 ns;	                

    boton_t <= '0';                   -- sigue rebotando
    wait for 3 ns;    
    wait until rising_edge(clk_t);    --  3 clk
    wait for 2 ns;	                
    assert led_t="0000"
      report "Fallo el led para 0000"
      severity failure; 

    wait until rising_edge(clk_t);    --  4 clk 
    wait for 2 ns;	 

    boton_t <= '1';                   -- sigue rebotando
    wait for 3 ns;    
    wait until rising_edge(clk_t);    --  5 clk
    wait until rising_edge(clk_t);    --  6 clk  
    wait until rising_edge(clk_t);    --  7 clk
    wait for 2 ns;	                

    boton_t <= '0';                 
    wait for 3 ns;      
    wait until rising_edge(clk_t);    --  8 clk
    wait until rising_edge(clk_t);    --  9 clk
    wait until rising_edge(clk_t);    -- 10 clk
    wait until rising_edge(clk_t);    -- 11 clk
    wait until rising_edge(clk_t);    -- 12 clk    
    wait for 2 ns;	                
    assert led_t="0000"
      report "Fallo el led para 0000" -- era ruido porque esta en 0
      severity failure;

    wait until rising_edge(clk_t);    -- no se acciona el boton
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    -------------------------------------------- acciono el boton
    boton_t <= '1';                   
    wait for 3 ns;
    wait until rising_edge(clk_t);    -- 0 clk    
    wait for 2 ns;	

    boton_t <= '0';                   -- supongamos que rebota
    wait for 3 ns;    
    wait until rising_edge(clk_t);    -- 1 clk
    wait for 2 ns;	                  -- sigue rebotando	

    boton_t <= '1';
    wait for 3 ns;
    wait until rising_edge(clk_t);    -- 2 clk
    wait for 2 ns;	                

    boton_t <= '0';                   -- sigue rebotando
    wait for 3 ns;    
    wait until rising_edge(clk_t);    -- 3 clk
    wait until rising_edge(clk_t);    -- 4 clk 
    wait for 2 ns;	 

    boton_t <= '1';                   -- sigue rebotando
    wait for 3 ns;    
    wait until rising_edge(clk_t);    -- 5 clk  
    wait until rising_edge(clk_t);    -- 6 clk    
    wait until rising_edge(clk_t);    -- 7 clk  
    wait until rising_edge(clk_t);    -- 8 clk
    wait for 2 ns;	    

    boton_t <= '0';                   -- sigue rebotando                 
    wait for 3 ns;    
    wait until rising_edge(clk_t);    -- 9 clk
    wait for 2 ns;	    
    
    boton_t <= '1';                   -- se estabiliza                 
    wait for 3 ns;
    wait until rising_edge(clk_t);    -- 10 clk
    wait until rising_edge(clk_t);    -- 11 clk
    wait until rising_edge(clk_t);    -- 12 clk
    wait for 2 ns;	    
    assert led_t="0001"
    report "Fallo el led para 0001"   -- era una presion valida
    severity failure; 
    
    wait until rising_edge(clk_t);    
    wait for 2 ns;
    --------------------------------------------- libero el boton    
    boton_t <= '0';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    -------------------------------------------- acciono el boton    
    boton_t <= '1';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '0';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    

    boton_t <= '1';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '1';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '0';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '1';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '1';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '0';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;	    
    
    boton_t <= '1';                 
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 2 ns;

    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);
    wait until rising_edge(clk_t);

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
    wait;
  end process; 
                     								  
end architecture Test;
---------------------------------------------------------------