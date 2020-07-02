-- 01.07.20 ----- Susana Canel ----- Resolucion.vhdl
-- EJEMPLO PARA ESTUDIAR COMO ACCIONA LA FUNCION 
-- DE RESOLUCION. MULTIPLEXOR DE 2 CANALES DESCRIPTO
-- DE MANERA DE PONER EN EVIDENCIA EL EFECTO DE LA
-- FUNCION DE RESOLUCION.
  
library ieee; 
use ieee.std_logic_1164.all;

----------------------------------------------------
entity Resolucion is
   port(a_i      : in  std_logic;
        b_i      : in  std_logic;
        sel_i    : in  std_logic;
        y_o      : out std_logic);
end entity Resolucion;
----------------------------------------------------
architecture Arq of Resolucion is begin
      
      y_o <= a_i  when sel_i='0' else
             'L';
             
      y_o <= b_i  when sel_i='1' else
             'L';
     
end architecture arq; 
----------------------------------------------------
