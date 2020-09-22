-- 21.09.20 ----------------- Susana Canel ----------------- Nat2Aik_tb_2.vhdl
-- TESTBENCH DEL CONVERSOR DE BCD NATURAL A BCD AIKEN. USANDO DATOS DE
-- TIPO BIT_VECTOR.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
----------------------------------------------------------------------------
entity Nat2Aik_tb_2 is
end entity Nat2Aik_tb_2;
----------------------------------------------------------------------------
architecture Test of Nat2Aik_tb_2 is
   ---------------------------------------------------
   component Nat2Aik_2 is
      port(n_i	 : in  std_logic_vector(3 downto 0);
           a_o   : out std_logic_vector(3 downto 0));
   end component Nat2Aik_2;
   ---------------------------------------------------
   signal n_t          : std_logic_vector(3 downto 0);
   signal a_t          : std_logic_vector(3 downto 0);
   file   inputHandle  : text;
   file   outputHandle : text;
begin
dut: Nat2Aik_2 port map(n_i => n_t,
		                  a_o => a_t);
  Prueba:
    process is
      variable numeroDeLinea   : integer := 0;
      variable estado          : file_open_status;
      variable buffer1         : line;
      variable buffer2         : line;
      variable auxN            : bit_vector(3 downto 0);
      variable auxA            : bit_vector(3 downto 0);
      constant ANCHO           : positive := 7;
   begin
      report "Probando el conversor de BCD natural a BCD Aiken"
      severity note;

   file_open( estado, inputHandle, "bcd-naturales.txt", read_mode );
   assert estado=open_ok
     report "No se pudo abrir el archivo con los datos"
     severity failure;
   file_open( estado, outputHandle, "bcd-aiken.txt", write_mode );
   assert estado=open_ok
     report "No se pudo crear el archivo para escribir los resultados"
     severity failure;
    ------------------------------------------------------------------------

    write( buffer2, string'( "BCD NATURAL CONVERTIDO" & LF));
    write( buffer2, string'( "      A BCD AIKEN"      & LF));
    writeline( outputHandle, buffer2 );
    write( buffer2, string'( "NATURAL" ), right, ANCHO);
    write( buffer2, string'(""         ), right, 8);
    write( buffer2, string'( "AIKEN"   ), right, ANCHO);
    writeline( outputHandle, buffer2 );
    write( buffer2, string'( "______________________") & LF );
    writeline( outputHandle, buffer2 );

    while not( endfile( inputHandle )) loop
      readline( inputHandle, buffer1 );
      read( buffer1, auxN );
      read( buffer1, auxA );

      n_t <= to_stdLogicVector(auxN);         -- inyecto el std_logic_vector
      wait for 2 ns;

      write( buffer2, auxN       , right, ANCHO);
      write( buffer2, string'(""), right, 8);
      write( buffer2, auxA       , right, ANCHO );
      writeline( outputHandle, buffer2 );

      numeroDeLinea := numeroDeLinea + 1;
      assert a_t = to_stdLogicVector (auxA)
        report "Error en la linea "
        & integer'image ( numeroDeLinea )
        & ". El BCD Aiken obtenido es "
        & integer'image (to_integer (unsigned ( a_t )))
        & " para BCD natural = "
        & integer'image (to_integer (unsigned ( n_t )))
        & " y deberia ser "
        & integer'image (to_integer (unsigned ( to_stdLogicVector (auxA) )))
        severity failure;

    end loop;

    file_close(  inputHandle );
    file_close( outputHandle );

    report "Prueba exitosa!"
    severity note;
    wait;
  end process Prueba;

end architecture Test;
----------------------------------------------------------------------------