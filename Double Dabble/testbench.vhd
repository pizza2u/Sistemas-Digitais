-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 13 (14/05/2021)
-- Double Dabble

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity testbench is
end testbench;

architecture test of testbench is

component doubledabble is

port(binary: in std_logic_vector(7 downto 0);
     reset: in std_logic;
     clk: in std_logic;
     unidade,dezena,centena: out std_logic_vector(3 downto 0);
     done: out std_logic);
     
end component;

signal binary: std_logic_vector(7 downto 0);
signal clk, reset: std_logic :='0';
signal unidade,dezena,centena : std_logic_vector(3 downto 0):=(others=>'0');
signal done: std_logic :='0';

type matriz is array(0 to 9) of std_logic_vector(0 to 7);

signal data_test: matriz :=("00001111",
							"00000111",
							"00010110",
							"00000010",
							"11010011",
							"00000110",
							"11111111",
							"00001000",
							"00110111",
							"00000101");

begin

dut: doubledabble port map(binary,reset,clk,unidade,dezena,centena,done);

  process 
    begin
   
   for j in 0 to 9 loop
   
    binary<=data_test(j);
    reset<='1'; 
    wait for 1 ns;
    reset<='0';
    wait for 1 ns;
    
    for i in 30 downto 0 loop
        clk<='1';
        wait for 1 ns;
        clk<='0';
        wait for 1 ns;
    end loop;
   end loop; 
    
    
  
   wait;
  end process;

end test;