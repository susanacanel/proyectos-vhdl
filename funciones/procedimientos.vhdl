-- 03.10.20 ------------------- Susana Canel ---------------- procedimientos.vhdl
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

----------------------- PARTE DECLARATIVA DEL PACKAGE ---------------------------
package procedimientos is

  -------------------------------------------------------------------------------
  procedure prepara_archivos    (file     ihandle  : text;
                                 file     ohandle  : text);
  -------------------------------------------------------------------------------
  procedure lee_datos (file  ihandle  : text;
                       str1           : out string;
                       str2           : out string);
  -------------------------------------------------------------------------------                         
  procedure escribe_resultados  (file     ohandle  : text;
                                 variable strN     : string;
                                 variable strA     : string);
  -------------------------------------------------------------------------------
  procedure cierra_archivos     (file     ihandle  : text;
                                 file     ohandle  : text);                      
---------------------------------------------------------------------------------

end package procedimientos;

---------------------------- CUERPO DEL PACKAGE ---------------------------------
package body procedimientos is

  -------------------------------------------------------------------------------
  -- Procedure: prepara_archivos
  -- Abre archivos con control de estado y escribe_resultados titulo y 
  -- encabezamiento en el archivo de salida.
  -------------------------------------------------------------------------------
  procedure prepara_archivos (file   ihandle  : text;
                              file   ohandle  : text) is
    variable estado    : file_open_status;
    variable buffer2   : line;    
    constant ANCHO     : positive := 7;    
  begin  
    file_open(estado, ihandle, "bcd-naturales_2.txt", read_mode);
    assert estado = open_ok
      report "No se pudo abrir el archivo con los datos"
      severity failure;
    file_open(estado, ohandle, "bcd-aiken.txt", write_mode);
    assert estado = open_ok
      report "No se pudo crear el archivo para escribir los resultados"
      severity failure;

    write(buffer2, string'("BCD NATURAL CONVERTIDO" & LF));
    write(buffer2, string'("     A BCD AIKEN"       & LF));
    writeline(ohandle, buffer2);

    write(buffer2, string'("NATURAL"), right, ANCHO);
    write(buffer2, string'("")       , right, 8);
    write(buffer2, string'("AIKEN")  , right, ANCHO);
    writeline(ohandle, buffer2);

    write(buffer2, string'("______________________") & LF);
    writeline(ohandle, buffer2);
  end procedure prepara_archivos;
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- Procedure: lee_datos
  -- lee el dato y el resultado esperado
  -------------------------------------------------------------------------------
  procedure lee_datos (file  ihandle  : text;
                       str1           : out string;
                       str2           : out string) is
    variable estado    : file_open_status;
    variable buffer1   : line;   
    variable espacio   : character; 
    constant ANCHO     : positive := 7;    
  begin 
    readline( ihandle, buffer1 );
    read( buffer1, str1 );
    read( buffer1, espacio );
    read( buffer1, str2 );
  end procedure lee_datos;  
---------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- Procedure: escribe_resultados
  -- Escribe los datos en el archivo de salida.
  -------------------------------------------------------------------------------
  procedure escribe_resultados (file     ohandle  : text;
                                variable strN     : string;
                                variable strA     : string) is
    variable buffer2   : line;                        
    constant ANCHO     : positive := 7; 
  begin    
    write(buffer2, strN       , right, ANCHO);
    write(buffer2, string'(""), right, 8);
    write(buffer2, strA       , right, ANCHO);
    writeline(ohandle, buffer2);
  end procedure escribe_resultados;

  -------------------------------------------------------------------------------
  -- Procedure: cierra_archivos
  -------------------------------------------------------------------------------
  procedure cierra_archivos (file   ihandle  : text;
                             file   ohandle  : text) is
  begin
    file_close( ihandle );
    file_close( ohandle );
  end procedure cierra_archivos;  
  -------------------------------------------------------------------------------

end package body procedimientos;
---------------------------------------------------------------------------------
