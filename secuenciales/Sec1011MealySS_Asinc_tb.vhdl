-- 06.06.20 --------------- Susana Canel -------------- Sec1011MealySS_Asinc_Asinc_tb.vhdl
-- TESTBENCH DE LA MAQUINA DE ESTADO MEALY. CIRCUITO QUE PONE UN "1" EN SU SALIDA 
-- CUANDO EN LOS ULTIMOS (Y PASADOS) TRES CICLOS DE RELOJ SE HAYA PRESENTADO EN
-- LA ENTRADA LA SECUENCIA 101 Y AHORA HAYA UN 1 EN LA ENTRADA. LA ENTRADA 
-- NO ESTA SINCRONIZADA CON EL RELOJ. SIN SOLAPAMIENTO. 
 
library ieee;  
use ieee.std_logic_1164.all;
------------------------------------------------------------------------------------------
entity Sec1011MealySS_Asinc_tb is
end entity Sec1011MealySS_Asinc_tb;
------------------------------------------------------------------------------------------
architecture Test of Sec1011MealySS_Asinc_tb is
   -----------------------------
  component Sec1011MealySS_Asinc is
    port(dat_i : in  std_logic; 
         rst_i : in  std_logic;
         clk_i : in  std_logic;
         sal_o : out std_logic);
  end component Sec1011MealySS_Asinc;
   -----------------------------
  signal clk_t        : std_logic :='1';
  signal rst_t        : std_logic :='1';
  signal dat_t        : std_logic :='0'; 
  signal sal_t        : std_logic ; 
  constant FRECUENCIA : integer   := 50;               -- en MHz
  constant PERIODO    : time      := 1 us/FRECUENCIA;  -- en ns
  signal detener      : boolean   := false;
  constant ESTIMULOS  : std_logic_vector(0 to 33):=("0101010111011101001011000011001011");
  constant ESPERADOS  : std_logic_vector(0 to 33):=("0000000010001000000001000000000001");	
begin
  dut: Sec1011MealySS_Asinc port map(clk_i => clk_t,
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
    report "Verificando el detector de 1011 sin solapamiento Mealy, entrada asincronica"
    severity note;

    wait until rst_t='0'; 
    wait for 3 ns; 	
	 
    for i in ESTIMULOS'range loop  
      dat_t <= ESTIMULOS(i);      
      wait for 1 ns;          
      assert sal_t=ESPERADOS(i)
        report "Falla en el bit " & integer'image(i) 
        severity warning;           -- para poder ver las "seniales" 
      wait for 1 ns;          
    end loop;
 																																			
      detener <= true;
      wait;
   end process Prueba;                      								  
end architecture Test;
------------------------------------------------------------------------------------------
