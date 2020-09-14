-- 14.09.20 ------------------------------------ Susana Canel ------------------------------------------ ProdEntN_tb.vhdl
-- TESTBENCH DEL PRODUCTO DE ENTEROS DE N BITS USANDO ARCHIVOS. MODIFICACION DEL ARCHIVO DE SALIDA.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;                    
-------------------------------------------------------------------------------------------------------------------------
entity ProdEntN_tb is
end entity ProdEntN_tb;
-------------------------------------------------------------------------------------------------------------------------
architecture Test of ProdEntN_tb is 
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

   --------- VARIABLES Y CONSTANTES PARA OBTENER EL ANCHO DE CADA COLUMNA DE LA TABLA DE SALIDA -------------------------
   
    constant ANCHOCOLUMNA_SEP  : positive := 4;

    variable n                 : integer  := 2**(BITS-1);      -- valor absoluto del maximo negativo de un entero,
                                                               -- con signo, rango: [-(2^n-1); (2^n-1)-1)]
    variable cantCaract        : integer  := 1;                -- por lo menos se imprime un caracter

  begin
    report "Verificando el multiplicador de enteros de 8 bits, de -128 a +127"
    severity note;
    ---------------------------------------------------------------------------------------------------------------------

    while n >= 10 loop                                          -- comparo con la base que en este caso es decimal (10)
      n          := n / 10; 
      cantCaract := cantCaract + 1; 
    end loop; 

    ---------------------------------------------------------------------------------------------------------------------
    file_open( estado, inputhandle, "factores.txt", read_mode );               
    assert estado=open_ok
      report "No se pudo abrir el archivo con los datos"
      severity failure;
    file_open( estado, outputhandle, "productos.txt", write_mode );            
    assert estado=open_ok
      report "No se pudo crear el archivo para escribir los resultados"
      severity failure;

    write( buffer2, string'( "PRODUCTO DE ENTEROS DE 8 BITS" & LF));           -- LF: line feed, caracter predefinido
    writeline( outputhandle, buffer2 );

    write( buffer2, string'( "A"        ), right, cantCaract + 1);             -- +1 considera la impresion del signo '-'
    write( buffer2, string'("    "      ), right, ANCHOCOLUMNA_SEP );
    write( buffer2, string'( "B"        ), right, cantCaract + 1);
    write( buffer2, string'("    "      ), right, ANCHOCOLUMNA_SEP );
    write( buffer2, string'( "PRODUCTO" & LF ), right, (cantCaract*2) + 1 ); -- considera: doble de caracteres p/el producto
    writeline( outputhandle, buffer2 );

    ---------------------------------------------------------------------------------------------------------------------
    while not( endfile( inputhandle )) loop
      readline( inputhandle, buffer1 );   
      read( buffer1, auxA );
      read( buffer1, auxB );
      read( buffer1, auxP );
                                                                       
      a_t <= std_logic_vector( to_signed( auxA, a_t'length ));
      b_t <= std_logic_vector( to_signed( auxB, b_t'length ));
      wait for 2 ns;

      write( buffer2, integer'image ( auxA ), right, cantCaract + 1);   
      write( buffer2, string' (" ")         , right, ANCHOCOLUMNA_SEP );
      write( buffer2, integer'image ( auxB ), right, cantCaract + 1);   
      write( buffer2, string' (" ")         , right, ANCHOCOLUMNA_SEP );
      write( buffer2, integer'image ( auxP ), right, (cantCaract*2) + 1); 
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
