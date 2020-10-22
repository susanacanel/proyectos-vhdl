-- 12.10.20 --------------------- Susana Canel -------------------- miPackage.vhdl
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
            ledSuma_o      : out std_logic;
            ledError_o     : out std_logic;           
            ledAcarreo_o   : out std_logic);
  end component sumSerie5;  
  --------------------------------------------------------------------------------
  component antirreboteValida is
    port (clk_i    : in  std_logic;
          rst_i    : in  std_logic;
          boton_i  : in  std_logic;
          valido_o : out std_logic);
  end component antirreboteValida;
  --------------------------------------------------------------------------------
  component antirreboteValida1 is
    port (clk_i    : in  std_logic;
          rst_i    : in  std_logic;
          boton_i  : in  std_logic;
          valido_o : out std_logic);
  end component antirreboteValida1;
  --------------------------------------------------------------------------------
  component binBCD is
    port (num_i              : in  std_logic_vector(3 downto 0);
          bcdEmpaquetado_o   : out std_logic_vector(7 downto 0));
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
  function to_stdLogVect( stringC     : string ) 
                          return        std_logic_vector;
  --------------------------------------------------------------------------------

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
  --------------------------------------------------------------------------------  

--------------------------------------------------------------------------------  

end package body miPackage;
----------------------------------------------------------------------------------
