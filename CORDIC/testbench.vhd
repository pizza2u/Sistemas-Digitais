-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 12 (08/05/2021)
-- CORDIC
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture test of testbench is

    component cordic is

        port(x1: in std_logic_vector(15 downto 0);
             y1: in std_logic_vector(15 downto 0);
             teta: in std_logic_vector(15 downto 0);
             x2: out std_logic_vector(15 downto 0);
             y2: out std_logic_vector(15 downto 0));

    end component;
	
    
    signal x2, y2: std_logic_vector (15 downto 0) := 16x"0000";
    
    
    signal x1, y1, teta: std_logic_vector (15 downto 0);
    
    
begin

	dut: cordic port map (x1, y1, teta, x2, y2);
    
    process
	begin
	
  		x1 <= x"0100";
  		y1 <= x"0000";
  		teta <= x"0000";
  		wait for 10 ns;
        
  		for i in 10 downto 0 loop
        
  			teta <= std_logic_vector(signed(teta) + x"0100");
    		wait for 10 ns;
            
  		end loop;

	wait for 15 ns;
	wait;
	end process;
 
end test;