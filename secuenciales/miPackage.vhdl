-- 25.11.20 --------------------- Susana Canel -------------------- miPackage.vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

-------------------------- PARTE DECLARATIVA DEL PACKAGE -------------------------
package miPackage is

	--------------------------------------------------------------------------------
	component CompNANDn is
		generic(N          : positive := 4);
		port   (entrada_i  : in  std_logic_vector(N-1 downto 0);
				    salida_o   : out std_logic);
	end component CompNANDn;
	--------------------------------------------------------------------------------
	component CompNORn is
		generic(N          : positive := 4);
		port   (entrada_i  : in  std_logic_vector(N-1 downto 0);
				    salida_o   : out std_logic);
	end component CompNORn;
	--------------------------------------------------------------------------------
  component CompMagN is
    generic(N     : positive := 4);
    port   (a_i   : in  std_logic_vector(N-1 downto 0);
            b_i   : in  std_logic_vector(N-1 downto 0);
            may_o : out std_logic;
            men_o : out std_logic;
            igu_o : out std_logic);
  end component CompMagN;
	--------------------------------------------------------------------------------
 	component CompEntN is
    generic(N      : positive := 4);
    port   (a_i    : in  std_logic_vector(N-1 downto 0);
            b_i    : in  std_logic_vector(N-1 downto 0);
            may_o  : out std_logic;
            men_o  : out std_logic;
            igu_o  : out std_logic);
     end component CompEntN;
  --------------------------------------------------------------------------------
  component SumMagN is
    generic(N     : positive := 3); 
    port   (a_i   : in  std_logic_vector(N-1 downto 0);
            b_i   : in  std_logic_vector(N-1 downto 0);
            ci_i  : in  std_logic_vector(0 downto 0);   
            sum_o : out std_logic_vector(N-1 downto 0);
            co_o  : out std_logic);
  end component SumMagN;
  --------------------------------------------------------------------------------
  component Display7segP is
    port(a_i          : in  std_logic_vector(3 downto 0);
         b_i          : in  std_logic_vector(3 downto 0);
         c_i          : in  std_logic_vector(3 downto 0);
         d_i          : in  std_logic_vector(3 downto 0);
         display0_o   : out std_logic_vector(6 downto 0);
         display1_o   : out std_logic_vector(6 downto 0);
         display2_o   : out std_logic_vector(6 downto 0);
         display3_o   : out std_logic_vector(6 downto 0));
  end component Display7segP;
  --------------------------------------------------------------------------------
  component divisor2frec is
  port (clk_i          : in  std_logic;
        rst_i          : in  std_logic; 
        clk1s_o        : out std_logic;   
        clk5ms_o       : out std_logic);   
  end component divisor2frec; 
  --------------------------------------------------------------------------------
  component sumSerie5 is
    generic(N              : positive := 4);
    port   (clk_i          : in  std_logic;
            rst_i          : in  std_logic;   
            pe_i           : in  std_logic;
            a_i            : in  std_logic_vector(N-1 downto 0);
            b_i            : in  std_logic_vector(N-1 downto 0);
            suma_o         : out std_logic_vector(N-1 downto 0);
            a_o            : out std_logic_vector(N-1 downto 0);           
            ledSuma_o      : out std_logic;
            ledError_o     : out std_logic;           
            ledAcarreo_o   : out std_logic);
  end component sumSerie5;  
  --------------------------------------------------------------------------------  
  component sumSerie6 is
    generic(N              : positive := 4);
    port   (clk_i          : in  std_logic;
            rst_i          : in  std_logic;   
            pe_i           : in  std_logic;
            a_i            : in  std_logic_vector(N-1 downto 0);
            b_i            : in  std_logic_vector(N-1 downto 0);
            suma_o         : out std_logic_vector(N-1 downto 0);
            a_o            : out std_logic_vector(N-1 downto 0); 
            b_o            : out std_logic_vector(N-1 downto 0);
            ledSuma_o      : out std_logic;
            ledError_o     : out std_logic;           
            ledAcarreo_o   : out std_logic);
  end component sumSerie6;  
  --------------------------------------------------------------------------------
  component antirreboteValida is
    port (clk_i    : in  std_logic;
          rst_i    : in  std_logic;
          boton_i  : in  std_logic;
          valido_o : out std_logic);
  end component antirreboteValida;
  --------------------------------------------------------------------------------
  component binBCD is
    port (num_i        : in  std_logic_vector(3 downto 0);
          bcdEmpaq_o   : out std_logic_vector(7 downto 0));
  end component binBCD;
  --------------------------------------------------------------------------------
  component display7seg is
    port(a_i       : in  std_logic_vector(3 downto 0);
         b_i       : in  std_logic_vector(3 downto 0);
         c_i       : in  std_logic_vector(3 downto 0);
         d_i       : in  std_logic_vector(3 downto 0);
         dig0_o    : out std_logic_vector(6 downto 0);
         dig1_o    : out std_logic_vector(6 downto 0);
         dig2_o    : out std_logic_vector(6 downto 0);
         dig3_o    : out std_logic_vector(6 downto 0));
  end component display7seg;
  --------------------------------------------------------------------------------  
  component sumSerieCir3 is
    port(clk_i     : in  std_logic;
         rst_i     : in  std_logic;   
         boton_i   : in  std_logic;           
         a_i       : in  std_logic_vector(3 downto 0); 
         b_i       : in  std_logic_vector(3 downto 0); 
         s_o       : out std_logic_vector(3 downto 0); 
         led_o     : out std_logic;  
         noBCD_o   : out std_logic;
         c_o       : out std_logic;
         ledV0_o   : out std_logic;
         ledV1_o   : out std_logic;
         ledV2_o   : out std_logic;
         ledV3_o   : out std_logic);
  end component sumSerieCir3;  
  ------------------------------------------------------------------------------------------------------------------------ 
  function to_stdLogVect( stringC  : string ) 
                          return     std_logic_vector;
  ------------------------------------------------------------------------------------------------------------------------
  procedure escribe_sram (constant direc   : in    integer;
                          constant dato    : in    integer;
                          signal   clk_t   : in    std_logic;                          
                          signal   dir_t   : inout std_logic_vector;
                          signal   cs_t    : inout std_logic;
                          signal   we_t    : inout std_logic;
                          signal   dat_t   : inout std_logic_vector);  
  ------------------------------------------------------------------------------------------------------------------------
  procedure lee_sram (constant direc   : in    integer;               -- "in" por omision la clase es "constant"
                      signal   clk_t   : in    std_logic;
                      signal   dir_t   : inout std_logic_vector;      -- "inout" por omision la clase es "variable"
                      signal   cs_t    : inout std_logic;
                      signal   oe_t    : inout std_logic;
                      signal   dat_t   : inout std_logic_vector;
                      variable dato    : out   std_logic_vector );   -- "out" por omision la clase es "variable";  
  ------------------------------------------------------------------------------------------------------------------------ 
  procedure verifica_sram (constant direccion  : in integer;
                           constant escrito    : in std_logic_vector;  
                           constant leido      : in std_logic_vector );
  ------------------------------------------------------------------------------------------------------------------------ 

end package miPackage;

----------------------------- CUERPO DEL PACKAGE ---------------------------------

package body miPackage is

  --------------------------------------------------------------------------------
  -- to_stdLogVect
  --------------------------------------------------------------------------------
  -- Funcion que convierte un string en un std_logic_vector
  --------------------------------------------------------------------------------
  function to_stdLogVect( stringC     : string ) 
                          return        std_logic_vector 
  is
    variable stdLogVectN : std_logic_vector(stringC'high - stringC'low downto 0);
    constant N           : positive := stringC'high-stringC'low+1; 
  begin
    for i in stringC'range loop
      case stringC(i) is
        when 'U'    => stdLogVectN(N-i) := 'U';
        when 'X'    => stdLogVectN(N-i) := 'X';
        when '0'    => stdLogVectN(N-i) := '0';
        when '1'    => stdLogVectN(N-i) := '1';
        when 'Z'    => stdLogVectN(N-i) := 'Z';
        when 'W'    => stdLogVectN(N-i) := 'W';
        when 'L'    => stdLogVectN(N-i) := 'L';
        when 'H'    => stdLogVectN(N-i) := 'H';
        when '-'    => stdLogVectN(N-i) := '-';
        when others => stdLogVectN(N-i) := 'X';
      end case;
    end loop;
    return stdLogVectN;
  end function to_stdLogVect;
  ------------------------------------------------------------------------------------------------------------------------  
  -- Procedure: escribe_sram
  -- Escribe los datos en la sram.
  ------------------------------------------------------------------------------------------------------------------------
  -- CICLO DE ESCRITURA
  -- tiempos minimos:
  -- constant   tWC           : time      := 100 ns;  -- Write Cycle Time
  -- constant   tAW           : time      :=  80 ns;  -- Address Valid to End of Write
  -- constant   tCW           : time      :=  80 ns;  -- Chip Select to End of Write
  -- constant   tDW           : time      :=  40 ns;  -- Data Valid to End of Write
  -- constant   tDH           : time      :=   0 ns;  -- Data Hold Time
  -- constant   tWP           : time      :=  60 ns;  -- Write Pulse Width
  -- constant   tAS           : time      :=   0 ns;  -- Address Setup Time
  -- constant   tWR           : time      :=   5 ns;  -- Write Recovery Time
  -- constant   tWLZ          : time      :=   5 ns;  -- Write Enable to Ouput Low-Z
  -- tiempos maximos:
  -- constant   tWHZ          : time      :=  tDW;  -- Write Enable to Ouput High-Z
  ------------------------------------------------------------------------------------------------------------------------
  procedure escribe_sram (constant direc   : in    integer;               -- "in" por omision la clase es "constant"
                          constant dato    : in    integer;
                          signal   clk_t   : in    std_logic;                          
                          signal   dir_t   : inout std_logic_vector;      -- "inout" por omision la clase es "variable"
                          signal   cs_t    : inout std_logic;
                          signal   we_t    : inout std_logic;
                          signal   dat_t   : inout std_logic_vector) is   -- "inout" por omision la clase es "variable"
  begin    
    dir_t <=  std_logic_vector(to_unsigned(direc, 4));
    wait for 10 ns;                                               -- tAS min 0 ns, Address Setup Time
    wait until rising_edge(clk_t);    
    wait for 3 ns;
    cs_t  <= '1'; 
    wait for 3 ns; 
    wait until rising_edge(clk_t);    
    wait for 3 ns;            
    we_t  <= '1';  
    wait for 3 ns; 
    wait until rising_edge(clk_t);    
    wait for 3 ns;        
    dat_t <= std_logic_vector(to_unsigned(dato, 4));  
    wait for 40 ns;	                                              -- tDW min 40 ns, Data Valid to End of Write
    dat_t <= "ZZZZ";
    cs_t  <= '0'; 
    we_t  <= '0';   
    wait for 5 ns;	                                              -- tWR min 5 ns, Write Recovery Time  
  end procedure escribe_sram;
  ------------------------------------------------------------------------------------------------------------------------ 
  -- Procedure: lee_sram
  -- Lee los datos de la sram.
  ------------------------------------------------------------------------------------------------------------------------ 
  -- CICLO DE LECTURA
  -- tiempos minimos: 
  -- constant   tRC           : time      := 100 ns;  -- Read Cycle Time
  -- constant   tOH           : time      :=  10 ns;  -- Output Hold from Address Change
  -- constant   tCLZ          : time      :=  10 ns;  -- Chip Select to Output Low-Z
  -- constant   tOLZ          : time      :=   5 ns;  -- Output Enable to Output Low-Z
  -- tiempos maximos:
  -- constant   tAA           : time      := 100 ns;  -- Address Access Time
  -- constant   tAC           : time      := 100 ns;  -- Chip Select Access Time
  -- constant   tOE           : time      :=  45 ns;  -- Output Enable to Output Valid
  -- constant   tCHZ          : time      :=  40 ns;  -- Chip Select to Output High-Z
  -- constant   tOHZ          : time      :=  40 ns;  -- Output Enable to Output High-Z  
  ------------------------------------------------------------------------------------------------------------------------ 
  procedure lee_sram (constant direc   : in    integer;               -- "in" por omision la clase es "constant"
                      signal   clk_t   : in    std_logic;
                      signal   dir_t   : inout std_logic_vector;      -- "inout" por omision la clase es "variable"
                      signal   cs_t    : inout std_logic;
                      signal   oe_t    : inout std_logic;
                      signal   dat_t   : inout std_logic_vector;
                      variable dato    : out   std_logic_vector ) is  -- "out" por omision la clase es "variable"
  begin    
    dir_t <= std_logic_vector(to_unsigned(direc, 4));
    wait for 3 ns;                                           -- ts y tp
    wait until rising_edge(clk_t);    
    wait for 2 ns;                                           -- th
    cs_t  <= '1'; 
    wait for 3 ns;
    wait until rising_edge(clk_t);    
    wait for 2 ns;        
    oe_t  <= '1';  
    wait for 3 ns;
    wait until rising_edge(clk_t);
    wait for 30 ns;	                                         -- tOE max 45 ns, Output Enable to Output Valid 
    dato := dat_t;                                                           
    wait for 40 ns;   
    wait until rising_edge(clk_t);       
    wait for 2 ns;    
    cs_t  <= '0'; 
    oe_t  <= '0';   
    wait for 3 ns;
    wait until rising_edge(clk_t);  
    wait for 3 ns;
  end procedure lee_sram;
  ------------------------------------------------------------------------------------------------------------------------ 
  -- Procedure: verifica_sram
  -- Verifica si el contenido de una determinada posicion de memoria de la sram es el esperado. 
  ------------------------------------------------------------------------------------------------------------------------ 
  procedure verifica_sram (constant direccion  : in integer;
                           constant escrito    : in std_logic_vector;  
                           constant leido      : in std_logic_vector ) is  
  begin                             
    assert leido=escrito 
      report "Falla para la direccion " 
      & integer'image(direccion) 
      & ". El dato grabado en la RAM fue " 
      & integer'image(to_integer(unsigned(escrito)))
      & ". Sin embargo al leer luego esa direccion se obtuvo: "
      & integer'image(to_integer(unsigned(leido)))
      & "."
      severity failure;
  end procedure verifica_sram;
  ------------------------------------------------------------------------------------------------------------------------ 

end package body miPackage;
--------------------------------------------------------------------------------------------------------------------------
