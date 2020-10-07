-- 02.10.20 -------------- Susana Canel -------------- Nat2Aik_func_pack_tb.vhdl
-- TESTBENCH DEL CONVERSOR DE BCD NATURAL A BCD AIKEN. USA ARCHIVOS Y DEFINE
-- UNA FUNCION PARA HACER LA CONVERSION DE LOS DATOS TIPO STRING A 
-- STD_LOGIC_VECTOR. USA UNA FUNCION DEFINIDA EN UN PACKAGE.  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.miPackage.all;    -- yo voy a usar el Package "miPackage" que esta 
                           -- en la carpeta miBiblioteca, con GHDL (en mi caso):
                     -- ghdl -a ../../libraries/vhdl/MiBiblioteca/miPackage.vhdl
--------------------------------------------------------------------------------
entity Nat2Aik_func_pack_tb is
end entity Nat2Aik_func_pack_tb;
--------------------------------------------------------------------------------
architecture Test of Nat2Aik_func_pack_tb is
  --------------------------------------------------
  component Nat2Aik_2 is
    port (n_i   : in  std_logic_vector(3 downto 0);
          a_o   : out std_logic_vector(3 downto 0));
  end component Nat2Aik_2;
  --------------------------------------------------
  signal n_t          : std_logic_vector(3 downto 0) := (others => '0');
  signal a_t          : std_logic_vector(3 downto 0);
  file   inputhandle  : text;
  file   outputhandle : text;
begin
  dut : Nat2Aik_2 port map(n_i => n_t,
                           a_o => a_t);
  Prueba:
  process is
    variable numeroDeLinea : integer := 0;
    variable estado        : file_open_status;
    variable buffer1       : line;
    variable buffer2       : line;
    variable stringN       : string(1 to 4);
    variable stringA       : string(1 to 4); 
    variable espacio       : character;  
    constant ANCHO         : positive := 7;
  begin
    report "Probando el conversor de BCD natural a BCD Aiken"
    severity note;
    ----------------------------------------------------------------------------
    file_open(estado, inputhandle, "bcd-naturales_2.txt", read_mode);
    assert estado = open_ok
      report "No se pudo abrir el archivo con los datos"
      severity failure;
    file_open(estado, outputhandle, "bcd-aiken.txt", write_mode);
    assert estado = open_ok
      report "No se pudo crear el archivo para escribir los resultados"
      severity failure;
    ----------------------------------------------------------------------------
    write(buffer2, string'("BCD NATURAL CONVERTIDO" & LF));
    write(buffer2, string'("     A BCD AIKEN"       & LF));
    writeline(outputHandle, buffer2);
    write(buffer2, string'("NATURAL"), right, ANCHO);
    write(buffer2, string'("")       , right, 8);
    write(buffer2, string'("AIKEN")  , right, ANCHO);
    writeline(outputHandle, buffer2);
    write(buffer2, string'("______________________") & LF);
    writeline(outputHandle, buffer2);

    while not(endfile(inputhandle)) loop
      readline(inputhandle, buffer1);
      read(buffer1, stringN);
      read(buffer1, espacio);
      read(buffer1, stringA);

      n_t <= to_stdLogVect( stringN );    
      wait for 2 ns;

      write(buffer2, stringN    , right, ANCHO);
      write(buffer2, string'(""), right, 8);
      write(buffer2, stringA    , right, ANCHO);
      writeline(outputhandle, buffer2);
      
      numeroDeLinea := numeroDeLinea + 1;
      assert a_t = to_stdLogVect( stringA )
        report "Error en la linea "
        & integer'image (numeroDeLinea)
        & ". El BCD Aiken obtenido es "
        & integer'image (to_integer (unsigned (a_t)))
        & " para BCD natural = "
        & integer'image (to_integer (unsigned (n_t)))
        & " y deberia ser "
        & integer'image (to_integer (unsigned (to_stdLogVect( stringA ) )))
        severity failure;
    end loop;
    ----------------------------------------------------------------------------
    file_close(inputhandle);
    file_close(outputhandle);

    report "Prueba exitosa!"
      severity note;
    wait;
  end process Prueba;
end architecture Test;
--------------------------------------------------------------------------------
