-- 05.04.19 -------------------------- Susana Canel ---------------------------- CompSumDisp.vhd
-- Exhibe en un display de 7 segmentos de 4 dígitos, las dos magnitudes BCDde entrada y 
-- si modo='1' muestra la mayor de ambas o apaga el display si la mayor no es BCD
-- si modo='0' muestra la suma BCD, si la suma es superior a 9, muestra la parte baja del digito 
-- BCD y enciende un LED.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------------------------------
entity CompSumDisp is
  port(a_i         : in  std_logic_vector(3 downto 0);
       b_i         : in  std_logic_vector(3 downto 0);
       modo_i      : in  std_logic;                    
       noBCD_o     : out std_logic;   
       display0_o  : out std_logic_vector(6 downto 0);
       display1_o  : out std_logic_vector(6 downto 0);
       display2_o  : out std_logic_vector(6 downto 0);
       display3_o  : out std_logic_vector(6 downto 0));
end entity CompSumDisp;
-------------------------------------------------------------------------------------------------
architecture Tabla of CompSumDisp is                    -- El LED SE ACTIVA CON '1'
   -----------------------------------------------------
   component CompMagN is
      generic(N     : positive := 4);
      port   (a_i   : in  std_logic_vector(N-1 downto 0);
              b_i   : in  std_logic_vector(N-1 downto 0);
              may_o : out std_logic;
              men_o : out std_logic;
              igu_o : out std_logic);
   end component CompMagN;
   -----------------------------------------------------
   component SumMagN is
      generic(N     : positive := 3); 
      port   (a_i   :  in std_logic_vector(N-1 downto 0);
              b_i   :  in std_logic_vector(N-1 downto 0);
              ci_i  :  in std_logic_vector(0   downto 0);   
              sum_o : out std_logic_vector(N-1 downto 0);
              co_o  : out std_logic
              );
   end component SumMagN;
   -------------------------------------------------------
   component Display7segP is
      port(a_i         : in  std_logic_vector(3 downto 0);
           b_i         : in  std_logic_vector(3 downto 0);
           c_i         : in  std_logic_vector(3 downto 0);
           d_i         : in  std_logic_vector(3 downto 0);
           display0_o  : out std_logic_vector(6 downto 0);
           display1_o  : out std_logic_vector(6 downto 0);
           display2_o  : out std_logic_vector(6 downto 0);
           display3_o  : out std_logic_vector(6 downto 0));
   end component Display7segP;
   -------------------------------------------------------
   signal mayor    : std_logic;	
   signal co       : std_logic;
   signal suma     : std_logic_vector(3 downto 0);	
   signal sumaBCD  : std_logic_vector(3 downto 0);   -- resultado en BCD
   signal mayMen   : std_logic_vector(3 downto 0);   -- a_i o b_i según > o <
   signal auxBCD   : std_logic;	                     -- número no BCD, >9
begin	
u1: component CompMagN generic map (N          => 4)
                       port    map (a_i        => a_i,
                                    b_i        => b_i,
                                    may_o      => mayor);             -- la sal.igu_o no la mapeo
u2: component SumMagN  generic map (N          => 4)
                       port    map (a_i        => a_i,
                                    b_i        => b_i,
                                    ci_i       => "0",                -- std_logic_vector
                                    sum_o      => suma,
                                    co_o       => co); 
u3: component Display7segP port map(a_i        => a_i,
                                    b_i        => b_i,
                                    c_i        => mayMen,
                                    d_i        => sumaBCD,
                                    display0_o => display0_o,
                                    display1_o => display1_o,
                                    display2_o => display2_o,
                                    display3_o => display3_o);  
                                                                              	 
   mayMen  <= a_i    when mayor='1'  and modo_i='1'            else      -- salida del comparador
              b_i    when mayor='0'  and modo_i='1'            else
              "0001" when auxBCD='1' and co='0' and modo_i='0' else
              "1010";  	                                                 -- >9 apaga el dígito
   auxBCD  <= '1' when suma > "1001" else
              '0';  
   sumaBCD <= suma when auxBCD='0' and modo_i='0' else
              std_logic_vector(unsigned(suma)-10) when auxBCD='1' and co='0' and modo_i='0' else
              "1010";                                                    -- >9 apaga el dígito          
   noBCD_o <= auxBCD;   
                                                                         -- '1' indica digito >9
end architecture Tabla;
-------------------------------------------------------------------------------------------------

