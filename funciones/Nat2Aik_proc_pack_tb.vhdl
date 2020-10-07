-- 05.10.20 ------------------------ Susana Canel ------------------- Nat2Aik_proc_pack_tb.vhdl
-- TESTBENCH DEL CONVERSOR DE BCD NATURAL A BCD AIKEN. USA ARCHIVOS Y DEFINE
-- UNA FUNCION PARA HACER LA CONVERSION DE LOS DATOS TIPO STRING A 
-- STD_LOGIC_VECTOR Y PROCEDIMIENTOS PARA ABRIR Y ESCRIBIR EN ARCHIVOS.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.miPackage.all;       -- El package miPackage esta en la carpeta miBiblioteca
use work.procedimientos.all;  -- El package procedimientos esta en la carpeta actual
-------------------------------------------------------------------------------------
entity Nat2Aik_proc_pack_tb is
end entity Nat2Aik_proc_pack_tb;
-------------------------------------------------------------------------------------
architecture Test of Nat2Aik_proc_pack_tb is
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
    variable stringN       : string(1 to 4);
    variable stringA       : string(1 to 4); 
    variable stdLogVectN   : std_logic_vector(3 downto 0);
    variable stdLogVectA   : std_logic_vector(3 downto 0);
  begin
    report "Probando el conversor de BCD natural a BCD Aiken"
    severity note;
    ---------------------------------------------------------------------------------
    prepara_archivos ( inputhandle, outputhandle );

    while not( endfile( inputhandle )) loop
      lee_datos( inputhandle, stringN, stringA );

      n_t <= to_stdLogVect( stringN );    
      wait for 2 ns;

      escribe_resultados ( outputhandle, stringN, stringA );
      
      numeroDeLinea := numeroDeLinea + 1;
      assert a_t = to_stdLogVect( stringA )
        report "Error en la linea "
        & integer'image ( numeroDeLinea )
        & ". El BCD Aiken obtenido es "
        & integer'image ( to_integer (unsigned (a_t) ))
        & " para BCD natural = "
        & integer'image ( to_integer (unsigned (n_t) ))
        & " y deberia ser "
        & integer'image ( to_integer (unsigned (to_stdLogVect( stringA ) )))
        severity failure;
    end loop;
    ---------------------------------------------------------------------------------
    cierra_archivos ( inputhandle, outputhandle );

    report "Prueba exitosa!"
      severity note;
    wait;
  end process Prueba;
end architecture Test;
-------------------------------------------------------------------------------------
