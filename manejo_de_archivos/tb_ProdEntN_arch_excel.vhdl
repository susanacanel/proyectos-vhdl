-- 14.09.20 ----------------------------------- Susana Canel ----------------------------------- tb_ProdEntN_arch_excel.vhdl
-- TESTBENCH DEL PRODUCTO DE ENTEROS DE N BITS USANDO ARCHIVOS. GENERACION DE UN ARCHIVO DE SALIDA CON FORMATO
-- COMPATIBLE CON UNA PLANILLA ELECTRONICA COMO, POR EJEMPLO, MICROSOFT OFFICE EXCEL.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
----------------------------------------------------------------------------------------------------------------------------
entity tb_ProdEntN_arch_excel is
end entity tb_ProdEntN_arch_excel;
----------------------------------------------------------------------------------------------------------------------------
architecture Test of tb_ProdEntN_arch_excel is
  ------------------------------------------------------
  component ProdEntN is
    generic(N    : positive  := 3);
    port   (a_i  : in  std_logic_vector(  N-1 downto 0);
            b_i  : in  std_logic_vector(  N-1 downto 0);
            p_o  : out std_logic_vector(2*N-1 downto 0) );
  end component ProdEntN;
  -------------------------------------------------------
  constant BITS          : positive := 8;
  signal   a_t           : std_logic_vector(  BITS-1 downto 0) := (others=>'0');
  signal   b_t           : std_logic_vector(  BITS-1 downto 0) := (others=>'0');
  signal   p_t           : std_logic_vector(2*BITS-1 downto 0);
  file     inputhandle   : text;
  file     outputhandle  : text;

begin
  dut: ProdEntN generic map(N    =>  BITS)
                port    map(a_i  =>  a_t,
                            b_i  =>  b_t,
                            p_o  =>  p_t);
  Prueba:
  process is
    variable numeroDeLinea     : integer := 0;
    variable estado            : file_open_status;
    variable buffer1           : line;
    variable buffer2           : line;
    variable auxA              : integer;
    variable auxB              : integer;
    variable auxP              : integer;

  begin
    report "Verificando el multiplicador de enteros de 8 bits, de -128 a +127"
    severity note;
    ------------------------------------------------------------------------------------------------------------------------
    file_open( estado, inputhandle, "factores3.txt", read_mode );
    assert estado=open_ok
      report "No se pudo abrir el archivo con los datos"
      severity failure;
    file_open( estado, outputhandle, "productos.xls", write_mode );   -- archivo de salida con extension para planilla excel
    assert estado=open_ok
      report "No se pudo crear el archivo para escribir los resultados"
      severity failure;

    write( buffer2, string'( "PRODUCTO DE ENTEROS DE 8 BITS" & LF)); -- LF: line feed, caracter predefinido, ASCII 10 decimal (0A)
    writeline( outputhandle, buffer2 );

    write( buffer2, string'( "A" &  HT ) );                          -- HT: horizontal tab, salta a la proxima posicion de tabulado,
    write( buffer2, string'( "B" &  HT ) );                          -- ASCII 9 decimal (09)
    write( buffer2, string'( "PRODUCTO" & LF ) );
    writeline( outputhandle, buffer2 );

    --------------------------------------------------------------------------------------------------------------------------------
    while not( endfile( inputhandle ) ) loop
      readline( inputhandle, buffer1 );
      read( buffer1, auxA );
      read( buffer1, auxB );
      read( buffer1, auxP );

      a_t <= std_logic_vector( to_signed( auxA, a_t'length ) );
      b_t <= std_logic_vector( to_signed( auxB, b_t'length ) );
      wait for 2 ns;

      write( buffer2, integer'image ( auxA ) &  HT );
      write( buffer2, integer'image ( auxB ) &  HT );
      write( buffer2, integer'image ( auxP ) );
      writeline ( outputhandle, buffer2 );

      numeroDeLinea := numeroDeLinea + 1;
      assert to_integer ( signed ( p_t )) = auxP
        report "Error en la linea "
        & integer'image ( numeroDeLinea )
        & ". El producto calculado es "
        & integer'image (to_integer (signed ( p_t )))
        & " para A = "
        & integer'image (to_integer (signed ( a_t )))
        & " y B = "
        & integer'image (to_integer (signed ( b_t )))
        & " y deberia ser "
        & integer'image ( auxP )
        severity failure;

    end loop;
    ------------------------------------------------------------------------------------------------------------------------

    file_close(  inputhandle );                                    -- cierre de archivos
    file_close( outputhandle );

    report "Verificacion exitosa!"
    severity note;
    wait;
  end process Prueba;
end architecture Test;
----------------------------------------------------------------------------------------------------------------------------
