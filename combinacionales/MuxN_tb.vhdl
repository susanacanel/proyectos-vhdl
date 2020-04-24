-- 19.10.18 --------------------------------------- Susana Canel ---------------------------------------------- MuxN.vhdl    
-- TESTBENCH DEL MUX DE N CANALES CON HABILITACION      
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------------------------------------------------------------------------
entity MuxN_tb is
end entity MuxN_tb;
-------------------------------------------------------------------------------------------------------------------------
architecture Test of MuxN_tb is 
	------------------------------------------------------------
   	component MuxN is
       		generic(N   : positive:=2);
       		port(i_i    : in  std_logic_vector(2**N-1 downto 0);
            	     sel_i  : in  std_logic_vector(N-1 downto 0);
		     ena_i  : in  std_logic;
            	     y_o    : out std_logic);
   	end component MuxN;
	------------------------------------------------------------
	signal i_t    : std_logic_vector(2**2-1 downto 0) := (others => '0');
	signal sel_t  : std_logic_vector(2-1 downto 0)    := (others => '0');
	signal ena_t  : std_logic := '0';
	signal y_t    : std_logic;
begin
dut: MuxN generic map(N     => 2)
          port    map(i_i   => i_t,
                      sel_i => sel_t,
		      ena_i => ena_t,
                      y_o   => y_t);
Prueba: process begin
      		report "Verificando el multiplexor generico con habilitacion"
      		severity note;

      		ena_t <= '1'; -------------------------------------------------------------------------------- Mux habilitado
		for j in 0 to 15 loop                      
      			i_t   <= std_logic_vector(to_unsigned(j,4));
			for i in 0 to 3 loop
				sel_t <= std_logic_vector(to_unsigned(i,2));
				wait for 1 ns;
				assert y_t=i_t(i)
					report "Falla para sel=" & integer'image(i) & " , i=" & integer'image(j) & " y ena=1"
					severity failure;
			end loop;
		end loop;                          
		  
      		ena_t <= '0'; ------------------------------------------------------------------------------ Mux inhabilitado
      		i_t   <= "0001"; 
      		sel_t <= "00";    
      		wait for 1 ns;
      		assert y_t='0'
        	report "Falla para sel=0, i=0001, ena=0 "
        	severity failure;                        
		
      		i_t   <= "1111"; 
      		sel_t <= "11";    
      		wait for 1 ns;
      		assert y_t='0'
        	report "Falla para sel=1111, i=1, ena=0 "
        	severity failure;
        
      		i_t   <= "1100"; 
      		sel_t <= "10";    
      		wait for 1 ns;
      		assert y_t='0'
        	report "Falla para sel=2, i=1100, ena=0 "
        	severity failure;               
            	        
      		i_t   <= "1010"; 
      		sel_t <= "01";    
      		wait for 1 ns;
      		assert y_t='0'
        	report "Falla para sel=1, i=1010, ena=0 "
        	severity failure;                                   
       	        		  
      		report "¡Verificación exitosa!"
      		severity note;
      		wait;
	end process Prueba;
end architecture Test;
-------------------------------------------------------------------------------------------------------------------------
