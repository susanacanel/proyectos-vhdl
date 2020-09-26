-- 25.09.20 ------------------ Susana Canel ------------------ Nat2Aik_tb_arch_std_log_vec.vhdl
-- TESTBENCH DEL CONVERSOR DE BCD NATURAL A BCD AIKEN. USA ARCHIVOS CON DATOS
-- DE TIPO STD_LOGIC_VECTOR.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
--------------------------------------------------------------------------------
entity Nat2Aik_tb_arch_std_log_vec is
end entity Nat2Aik_tb_arch_std_log_vec;
--------------------------------------------------------------------------------
architecture Test of Nat2Aik_tb_arch_std_log_vec is
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
    variable stdLogVectN   : std_logic_vector(3 downto 0);
    variable stdLogVectA   : std_logic_vector(3 downto 0);
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
    ----------------------------------------------------------------------------
    -- El "read" de un string no "gasta" los espacios en blanco como si lo hacen 
    -- los "read" de enteros, booleans, etc.
    -- (Es logico, uno podria querer leer un string con espacios antes o despues)
    -- Por eso hay que leer el espacio separador antes de leer el ultimo string.

    while not(endfile(inputhandle)) loop
      readline(inputhandle, buffer1);
      read(buffer1, stringN);
      read(buffer1, espacio);
      read(buffer1, stringA);
                                -- std_logic_vector(3 downto 0)  3=4-1, 2=4-2...
      for i in 1 to 4 loop
        case stringN(i) is
          when 'U'    => stdLogVectN(4 - i) := 'U';
          when 'X'    => stdLogVectN(4 - i) := 'X';
          when '0'    => stdLogVectN(4 - i) := '0';
          when '1'    => stdLogVectN(4 - i) := '1';
          when 'Z'    => stdLogVectN(4 - i) := 'Z';
          when 'W'    => stdLogVectN(4 - i) := 'W';
          when 'L'    => stdLogVectN(4 - i) := 'L';
          when 'H'    => stdLogVectN(4 - i) := 'H';
          when '-'    => stdLogVectN(4 - i) := '-';
          when others => stdLogVectN(4 - i) := 'X';
        end case;
      end loop;

      n_t <= stdLogVectN;
      wait for 2 ns;

      write(buffer2, stringN    , right, ANCHO);
      write(buffer2, string'(""), right, 8);
      write(buffer2, stringA    , right, ANCHO);
      writeline(outputhandle, buffer2);

      for i in 1 to 4 loop
        case stringA(i) is
          when 'U'    => stdLogVectA(4 - i) := 'U';
          when 'X'    => stdLogVectA(4 - i) := 'X';
          when '0'    => stdLogVectA(4 - i) := '0';
          when '1'    => stdLogVectA(4 - i) := '1';
          when 'Z'    => stdLogVectA(4 - i) := 'Z';
          when 'W'    => stdLogVectA(4 - i) := 'W';
          when 'L'    => stdLogVectA(4 - i) := 'L';
          when 'H'    => stdLogVectA(4 - i) := 'H';
          when '-'    => stdLogVectA(4 - i) := '-';
          when others => stdLogVectA(4 - i) := 'X';
        end case;
      end loop;
      
      numeroDeLinea := numeroDeLinea + 1;
      assert a_t = stdLogVectA
        report "Error en la linea "
        & integer'image (numeroDeLinea)
        & ". El BCD Aiken obtenido es "
        & integer'image (to_integer (unsigned (a_t)))
        & " para BCD natural = "
        & integer'image (to_integer (unsigned (n_t)))
        & " y deberia ser "
        & integer'image (to_integer (unsigned (stdLogVectA)))
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