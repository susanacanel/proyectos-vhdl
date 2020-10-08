-- 07.10.20 ------------------- Susana Canel ---------------- package_escribe.vhdl
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

----------------------- PARTE DECLARATIVA DEL PACKAGE ---------------------------
package package_escribe is

  -------------------------------------------------------------------------------
  procedure prepara_archivo (file ohandle  : text);
  -------------------------------------------------------------------------------                         
  procedure escribe_tabla  (file     ohandle   : text;
                            variable nro       : integer;
                            variable resultado : integer);
  -------------------------------------------------------------------------------
  procedure cierra_archivo (file ohandle  : text);                      
---------------------------------------------------------------------------------

end package package_escribe;

---------------------------- CUERPO DEL PACKAGE ---------------------------------
package body package_escribe is

  -------------------------------------------------------------------------------
  -- Procedure: prepara_archivo
  -- Abre archivo con control de estado y escribe en el archivo de salida 
  -- la tabla con  titulo y encabezamiento .
  -------------------------------------------------------------------------------
  procedure prepara_archivo (file   ohandle  : text) is
    variable estado    : file_open_status;
    variable buffer1   : line;    
    constant ANCHO     : positive := 7;    
  begin  
    file_open(estado, ohandle, "tabla_del_siete.txt", write_mode);
    assert estado = open_ok
      report "No se pudo crear el archivo para escribir los resultados"
      severity failure;

    write(buffer1, string'("TABLA DEL SIETE" & LF));
    write(buffer1, string'("_______________") & LF);
    writeline(ohandle, buffer1);
  end procedure prepara_archivo;
  -------------------------------------------------------------------------------

  -------------------------------------------------------------------------------
  -- Procedure: escribe_tabla
  -- Escribe los datos en el archivo de salida.
  -------------------------------------------------------------------------------
  procedure escribe_tabla  (file     ohandle   : text;
                            variable nro       : integer;
                            variable resultado : integer) is
    variable buffer1   : line;                        
    constant ANCHO     : positive := 4; 
  begin    
    write(buffer1, nro        , right, ANCHO);
    write(buffer1, string'(""), right, 7);
    write(buffer1, resultado  , right, ANCHO);
    writeline(ohandle, buffer1);
  end procedure escribe_tabla;

  -------------------------------------------------------------------------------
  -- Procedure: cierra_archivo
  -------------------------------------------------------------------------------
  procedure cierra_archivo (file   ohandle  : text) is
  begin
    file_close( ohandle );
  end procedure cierra_archivo;  
  -------------------------------------------------------------------------------

end package body package_escribe;
---------------------------------------------------------------------------------