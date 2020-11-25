-- 25.11.20 ------------------ Susana Canel ---------------------- sram_io_tb.vhdl
-- TESTBENCH DE UNA SRAM SINCRONICA, CON BUS BIDIRECCIONAL. USA PROCEDIMIENTOS Y
-- PACKAGE PROPIO.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.miPackage.all;
----------------------------------------------------------------------------------
entity sram_io_tb is
end entity sram_io_tb;
----------------------------------------------------------------------------------
architecture Test of sram_io_tb is
  --------------------------------------------------------------------------------
  component sram_io is
    generic(DIREC  : positive := 4; 	    -- 4 lineas direccionan, 2^4=16 palabras
            BITS   : positive := 4);      -- 4 bits por palabra
    port   (clk_i  : in  std_logic;
            dir_i  : in  std_logic_vector(DIREC-1 downto 0);
            oe_i   : in  std_logic;
            we_i   : in  std_logic;	
            cs_i   : in  std_logic;
            dat_io : inout  std_logic_vector(BITS-1 downto 0));
  end component sram_io;		  
  --------------------------------------------------------------------------------
  constant NBITS         : integer   := 4;
  constant NDIR          : integer   := 4;
  signal   clk_t         : std_logic := '1';
  signal   dir_t         : std_logic_vector(NDIR-1 downto 0):= (others=>'0');
  signal   oe_t          : std_logic := '0';
  signal   we_t          : std_logic := '0';
  signal   cs_t          : std_logic := '0';
  signal   dat_t         : std_logic_vector(NBITS-1 downto 0) := (others=>'Z');
  constant FRECUENCIA    : integer   := 50;              -- en MHz
  constant PERIODO       : time      := 1 us/FRECUENCIA; -- en ns
  signal   detener       : boolean   := false; 
begin
  dut : sram_io  generic map(DIREC  => NDIR,
                             BITS   => NBITS)
                 port    map(clk_i  => clk_t,
                             dir_i  => dir_t,
  		                       oe_i   => oe_t,
  		                       we_i   => we_t,
  		                       cs_i   => cs_t,
  			                     dat_io => dat_t);
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
  process is
    variable dato : std_logic_vector(NBITS-1 downto 0);
  begin
    report "Verificando la ram estatica de 16 palabras de 4 bits"
    severity note;

    dat_t <= "ZZZZ";
    wait for 30 ns;
    
    -- VARIOS CICLOS DE ESCRITURA
    for i in 0 to 9 loop
      escribe_sram (i, 9-i, clk_t, dir_t, cs_t, we_t, dat_t);        
    end loop;    
  
    lee_sram (7, clk_t, dir_t, cs_t, oe_t, dat_t, dato);      
    verifica_sram (7, "0010", dato);

    escribe_sram (7, 7, clk_t, dir_t, cs_t, we_t, dat_t);   
    lee_sram (7, clk_t, dir_t, cs_t, oe_t, dat_t, dato);      
    verifica_sram (7, "0111", dato);
    
    escribe_sram (11, 6, clk_t, dir_t, cs_t, we_t, dat_t);   

    escribe_sram (3, 5, clk_t, dir_t, cs_t, we_t, dat_t); 

    lee_sram (11, clk_t, dir_t, cs_t, oe_t, dat_t, dato);      
    verifica_sram (11, "0110", dato);      
   
    escribe_sram (9, 4, clk_t, dir_t, cs_t, we_t, dat_t);   
    lee_sram (9, clk_t, dir_t, cs_t, oe_t, dat_t, dato);  
    verifica_sram (9, "0100", dato); 

    lee_sram (3, clk_t, dir_t, cs_t, oe_t, dat_t, dato); 
    verifica_sram (3, "0101", dato);

    lee_sram (0, clk_t, dir_t, cs_t, oe_t, dat_t, dato); 
    verifica_sram (0, "1001", dato);

    lee_sram (4, clk_t, dir_t, cs_t, oe_t, dat_t, dato); 
    verifica_sram (4, "0101", dato);

    escribe_sram (5, 13, clk_t, dir_t, cs_t, we_t, dat_t); 

    escribe_sram (15, 10, clk_t, dir_t, cs_t, we_t, dat_t); 

    lee_sram (5, clk_t, dir_t, cs_t, oe_t, dat_t, dato); 
    verifica_sram (5, "1101", dato);
  
    lee_sram (15, clk_t, dir_t, cs_t, oe_t, dat_t, dato); 
    verifica_sram (15, "1010", dato);   

    report "Verificacion exitosa!"
    severity note;
    detener <= true;
    wait;
  end process Prueba;                      
end architecture Test;
----------------------------------------------------------------------------------
