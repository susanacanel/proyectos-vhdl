-- 12.05.19 ------------- Susana Canel ------------ FFD_tb.vhdl  
-- TESTBENCH DEL FLIP-FLOP D, DISPARADO POR FLANCO POSITIVO.

library ieee;
use ieee.std_logic_1164.all;
----------------------------------------------------------------
entity FFD_tb is
end entity FFD_tb;
----------------------------------------------------------------
architecture Test of FFD_tb is 
   --------------------------------
   component FFD is
      port(d_i    : in  std_logic;
           clk_i  : in  std_logic; 
           q_o    : out std_logic);
   end component FFD;
   --------------------------------
   signal   d_t        : std_logic := '0';
   signal   clk_t      : std_logic := '0';
   signal   q_t        : std_logic;
   constant FRECUENCIA : integer   := 50;              -- en MHz
   constant PERIODO    : time      := 1 us/FRECUENCIA; -- en ns=20
   signal   detener    : boolean   := false;
	
begin
dut : FFD port map(d_i   => d_t,
                   clk_i => clk_t, 
                   q_o   => q_t);
   -------------------------------------
   GeneraReloj: 
   process begin 	
      clk_t <= '1', '0' after PERIODO/2;
      wait for PERIODO;
      if detener then
         wait;
      end if;
   end process GeneraReloj;
   -------------------------------------						 
   Prueba:
   process begin
      report "Verificando el ff D"
      severity note;
      
      d_t  <= '1';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='1'
	 report "Falla para d=1" 
         severity failure;
			
      wait for 10 ns; 
      d_t  <= '0';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='0'
         report "Falla para d=0" 
         severity failure;
					         
      wait for 10 ns;			
      d_t  <= '1';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='1'
	 report "Falla para d=1" 
         severity failure;			
	
      wait for 10 ns;			
      d_t  <= '1';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='1'
	 report "Falla para d=1" 
         severity failure;	
	
      wait for 10 ns; 
      d_t  <= '0';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='0'
         report "Falla para d=0" 
         severity failure;
	
      wait for 10 ns;			
      d_t  <= '1';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='1'
	 report "Falla para d=1" 
         severity failure;

      wait for 10 ns; 
      d_t  <= '0';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='0'
         report "Falla para d=0" 
         severity failure;

      wait for 10 ns; 
      d_t  <= '0';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='0'
         report "Falla para d=0" 
         severity failure;

      wait for 10 ns;			
      d_t  <= '1';
      wait for 5 ns;                     -- genera ts
      wait until rising_edge(clk_t);
      wait for 5 ns;		         -- espera tp
      assert q_t='1'
	 report "Falla para d=1" 
         severity failure;

      report "Verificacion exitosa!"
      severity note;
      detener <= true;
      wait;
   end process Prueba;                      	
end architecture Test;
----------------------------------------------------------------
