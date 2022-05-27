-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 11 (01/05/2021)
-- "PROBLEM 8.2 FROM CIRCUIT DESIGN WITH VHDL"

library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench;

architecture test of testbench is

component QUESTAO8_2 is

port(clock: in std_logic;
     OUT1 ,OUT2: out std_logic);

end component;

signal clock: std_logic := '0';
signal OUT1, OUT2: std_logic := '0';

begin

dut: QUESTAO8_2 port map(clock, OUT1, OUT2);

  process
   begin
  

      for i in 0 to 16 loop
	     clock <= '0';
	     wait for 5 ns;
	     clock <= '1';
	     wait for 5 ns;
    
         
      end loop;

    wait;

 end process;


end test;
