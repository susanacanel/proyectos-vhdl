-- 07.04.19 -------------- Susana Canel ------------- Display7segP_tb.vhdl
-- TESTBENCH PARA EL DISPLAY DE 4 DIGITOS DE 7 SEGMENTOS.

library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------------------
entity Display7segP_tb is
end entity Display7segP_tb;
--------------------------------------------------------------------------
architecture Test of Display7segP_tb is
   --------------------------------------------------------
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
   --------------------------------------------------------
   signal a_t     : std_logic_vector(3 downto 0) := (others=>'0');
   signal b_t     : std_logic_vector(3 downto 0) := (others=>'0');
   signal c_t     : std_logic_vector(3 downto 0) := (others=>'0');
   signal d_t     : std_logic_vector(3 downto 0) := (others=>'0');
   signal disp0_t : std_logic_vector(6 downto 0);
   signal disp1_t : std_logic_vector(6 downto 0);
   signal disp2_t : std_logic_vector(6 downto 0);
   signal disp3_t : std_logic_vector(6 downto 0);
begin	
dut: Display7segP port map(a_i        => a_t,
                           b_i        => b_t, 
                           c_i        => c_t,  
                           d_i        => d_t,  
                           display0_o => disp0_t,
                           display1_o => disp1_t,  
                           display2_o => disp2_t, 
                           display3_o => disp3_t); 	
Prueba:
   process begin
      report "Verificando el display de 4 dígitos de 7 segmentos"
      severity note;

      a_t <= "1001";
      b_t <= "0001";
      c_t <= "0000";
      d_t <= "0010";
      wait for 1 ns;
      assert disp0_t = not "1101111"  --los segmentos se encienden con '0'
         report "Falla para a=1001"
         severity failure;
      assert disp1_t = not "0000110"
         report "Falla para a=1001"
         severity failure;
      assert disp2_t = not "0111111"
         report "Falla para a=1001"
         severity failure; 
      assert disp3_t = not "1011011"
         report "Falla para a=1001"
         severity failure;

      report "¡Verificación exitosa!"
      severity note;
      wait;
   end process Prueba;                              
end architecture Test;
--------------------------------------------------------------------------
