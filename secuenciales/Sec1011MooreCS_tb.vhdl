-- 05.06.2020 ---------------------- Susana Canel ----------------------- Sec1011MooreCS_tb.vhdl
-- TESTBENCH DE LA MAQUINA DE ESTADO MOORE. CIRCUITO QUE PONE UN "1" EN SU SALIDA CUANDO EN LOS 
-- ULTIMOS (Y PASADOS) CUATRO CICLOS DE RELOJ SE HAYA PRESENTADO EN LA ENTRADA LA SECUENCIA 1011
-- LA ENTRADA ESTA SINCRONIZADA CON EL RELOJ. CON SOLAPAMIENTO. 

library ieee;  
use ieee.std_logic_1164.all;
------------------------------------------------------------------------------------------------
entity Sec1011MooreCS_tb is
end entity Sec1011MooreCS_tb;
------------------------------------------------------------------------------------------------
architecture Test of Sec1011MooreCS_tb is
   -----------------------------
  component Sec1011MooreCS is    
    port(clk_i : in  std_logic;    
         rst_i : in  std_logic;       
         dat_i : in  std_logic;            
         sal_o : out std_logic);    
  end component Sec1011MooreCS;  
   -----------------------------
  signal   clk_t      : std_logic :='1';
  signal   rst_t      : std_logic :='1';
  signal   dat_t      : std_logic :='0'; 
  signal   sal_t      : std_logic; 
  constant FRECUENCIA : integer   := 50;               -- en MHz
  constant PERIODO    : time      := 1 us/FRECUENCIA;  -- en ns
  signal   detener    : boolean   := false;
  constant ESTIMULOS  : std_logic_vector(0 to 45):=("0110110110111011101100100101100001100101101111");
  constant ESPERADOS  : std_logic_vector(0 to 45):=("0000001001001000100010000000010000000000010010");	
begin
  dut: Sec1011MooreCS port map(clk_i => clk_t,
	                             rst_i => rst_t,
		                           dat_i => dat_t,
				                       sal_o => sal_t);
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

  rst_t <= '1', '0' after PERIODO*3/2;

  Prueba:
  process begin
    report "Verificando el detector de la secuencia 1011 con solapamiento, salida Moore"
    severity note;

    wait until rst_t='0'; 
    wait for 3 ns; 	        -- espera tp y genera ts
	 
    for i in ESTIMULOS'range loop
      wait until rising_edge(clk_t);
      wait for 1 ns;          
      dat_t <= ESTIMULOS(i);      
      wait for 3 ns;          
      assert sal_t=ESPERADOS(i)
        report "Falla en el bit " & integer'image(i) 
        severity failure; 
    end loop;
 																																			
    report "Verificacion exitosa!"
    severity note;
    detener <= true;
    wait;
  end process Prueba;                      								  
end architecture Test;
------------------------------------------------------------------------------------------------