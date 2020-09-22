-- 12.09.20 ------------------------------------ Susana Canel ------------------------------------------ tb_ProdEntN_arch_sal_desprolija.vhdl
-- TESTBENCH DEL PRODUCTO DE ENTEROS DE N BITS USANDO ARCHIVOS.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;                    -- "package" para usar las funciones y tipos para manejar archivos
                                       -- esta en la "library std", no es necesario declarar esta "library"

-------------------------------------------------------------------------------------------------------------------------
entity tb_ProdEntN_arch_sal_desprolija is
end entity tb_ProdEntN_arch_sal_desprolija;
-------------------------------------------------------------------------------------------------------------------------
architecture Test of tb_ProdEntN_arch_sal_desprolija is
  ------------------------------------------------------
  component ProdEntN is
    generic(N    : positive  := 3);
    port   (a_i  : in  std_logic_vector(  N-1 downto 0);
            b_i  : in  std_logic_vector(  N-1 downto 0);
            p_o  : out std_logic_vector(2*N-1 downto 0)
           );
  end component ProdEntN;
  -------------------------------------------------------
  constant BITS  : positive := 8;
  signal   a_t   : std_logic_vector(  BITS-1 downto 0) := (others=>'0');
  signal   b_t   : std_logic_vector(  BITS-1 downto 0) := (others=>'0');
  signal   p_t   : std_logic_vector(2*BITS-1 downto 0);

  -------------------------------------------------------------------------------------------------------------------
  -- Voy a usar un archivo (file) de texto (text), no binario, al cual el sistema operativo le asigna un "filehandle"
  -- (un numero de referencia) cuando realiza la apertura del archivo. Son necesarias las siguientes sentencias:
  -------------------------------------------------------------------------------------------------------------------

  file  inputhandle   : text;            -- para el archivo de entrada
  file  outputhandle  : text;            -- para el archivo de salida

begin
  dut: ProdEntN generic map(N    =>  BITS)
                port    map(a_i  =>  a_t,
                            b_i  =>  b_t,
                            p_o  =>  p_t);
  Prueba:
  process is
    variable numeroDeLinea  : integer := 0;        -- para informar la linea donde se ha producido un eventual error

    ----------------------------------------------------------------------------------------------------------------
    --  DEFINICION DE VARIABLES NECESARIAS PARA EL MANEJO DE ARCHIVOS:
    ----------------------------------------------------------------------------------------------------------------

    variable estado            : file_open_status;    -- para el resultado de la operacion de apertura
                                                      -- buffers en RAM:
    variable buffer1           : line;                -- donde se encuentra la linea (line) leida desde el archivo
    variable buffer2           : line;                -- y donde se va armando la linea (line) a escribir en el archivo
    variable auxA              : integer;             -- variable auxiliare del dato a leer desde el archivo.
    variable auxB              : integer;             -- variable auxiliare del dato a leer desde el archivo.
    variable auxP              : integer;             -- variable auxiliare de los resultados a escribir en el archivo.

    constant ANCHOCOLUMNA_A    : positive := 4;
    constant ANCHOCOLUMNA_B    : positive := 4;
    constant ANCHOCOLUMNA_P    : positive := 8;
    constant ANCHOCOLUMNA_SEP  : positive := 4;
  begin
    report "Verificando el multiplicador de enteros de 8 bits"
    severity note;

    ----------------------------------------------------------------------------------------------------------------
    -- APERTURA DE ARCHIVOS CON CONTROL DEL ESTADO OK.
    --
    -- Especifico cual es el archivo de lectura y el de escritura, que en este caso se encuentran en el directorio
    -- actual. Se llaman:
    -- "factores.txt" el de entrada y
    -- "productos.txt" el de salida.
    --
    -- Controlo el siguiente estado:
    -- open_ok : se pudo abrir un archivo de lectura (read_mode) o
    --           se pudo eliminar si existia, crear y abrir un archivo de escritura (write_mode) o
    --           se pudo abrir un archivo existente para escribir a partir del final (append_mode)
    ----------------------------------------------------------------------------------------------------------------

    file_open( estado, inputhandle, "factores.txt", read_mode );               -- en modo lectura
    assert estado=open_ok
      report "No se pudo abrir el archivo con los datos"
      severity failure;


    file_open( estado, outputhandle, "productos.txt", write_mode );            -- en modo escritura
    assert estado=open_ok
      report "No se pudo crear el archivo para escribir los resultados"
      severity failure;

    ----------------------------------------------------------------------------------------------------------------
    -- ESCRITURA DEL TITULO Y ENCABEZAMIENTO DE LAS COLUMNAS EN EL ARCHIVO DE SALIDA.
    ----------------------------------------------------------------------------------------------------------------

    write( buffer2, string'( "PRODUCTO DE ENTEROS DE 8 BITS" ));
    writeline( outputhandle, buffer2 );

    write( buffer2, string'(" "));                                 -- para dejar un renglon en blanco
    writeline( outputhandle, buffer2 );

    write( buffer2, string'( "A" )       , right, ANCHOCOLUMNA_A );
    write( buffer2, string'("    ")      , right, ANCHOCOLUMNA_SEP );
    write( buffer2, string'( "B" )       , right, ANCHOCOLUMNA_B );
    write( buffer2, string'("    ")      , right, ANCHOCOLUMNA_SEP );
    write( buffer2, string'( "PRODUCTO" ), right);
    writeline( outputhandle, buffer2 );

    write( buffer2, string'(" "));
    writeline( outputhandle, buffer2 );

    ----------------------------------------------------------------------------------------------------------------
    -- A continuacion, con todo preparado, comienza un lazo que realiza las siguientes acciones:
    -- Mientras no encuentre un fin de archivo,
    -- * lee los datos y el resultado esperado desde el archivo de entrada,
    -- * inyecta los datos al dispositivo instanciado,
    -- * escribe el archivo de salida,
    -- * analiza sin hay algun error en el resultado obtenido, si lo hay, lo informa.
    ----------------------------------------------------------------------------------------------------------------
    -- readline: el sistema operativo lee toda una linea del archivo y la guarda en la variable "buffer1".
    --           Deja un puntero apuntando al primer caracter de "buffer1".

    -- read    : el primer "read" guarda en la variable "auxA" el primer caracter leido desde la variable "buffer1".
    --           Y deja el puntero apuntando al caracter siguiente.
    --           Los siguientes "read" hacen lo mismo con los otros dos valores.
    ----------------------------------------------------------------------------------------------------------------

    while not( endfile( inputhandle )) loop

      readline( inputhandle, buffer1 );

      read( buffer1, auxA );
      read( buffer1, auxB );
      read( buffer1, auxP );

      a_t <= std_logic_vector( to_signed( auxA, a_t'length ));
      b_t <= std_logic_vector( to_signed( auxB, b_t'length ));
      wait for 2 ns;

      write( buffer2, integer'image ( auxA ), right, ANCHOCOLUMNA_A );
      write( buffer2, string' (" ")         , right, ANCHOCOLUMNA_SEP );
      write( buffer2, integer'image ( auxB ), right, ANCHOCOLUMNA_B );
      write( buffer2, string' (" ")         , right, ANCHOCOLUMNA_SEP );
      write( buffer2, integer'image ( auxP ), right, ANCHOCOLUMNA_P );

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
    -------------------------------------------------------------------------------------------------------------------

    file_close(  inputhandle );                                    -- cierre de archivos
    file_close( outputhandle );

    report "Verificacion exitosa!"
    severity note;
    wait;
  end process Prueba;
end architecture Test;
-------------------------------------------------------------------------------------------------------------------------
