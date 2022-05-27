--testbench.vhd
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench;

architecture test of testbench is

  component CD4511 is
  port(d: in std_logic_vector(3 downto 0);
         le,lt,bl: in std_logic;
         output: out std_logic_vector(6 downto 0) --na ordem g - f - e - d - c - b - a
  );
  end component;

  signal d: std_logic_vector(3 downto 0);
  signal le,lt,bl:  std_logic;
  signal output: std_logic_vector(6 downto 0); 

  begin

    dut: CD4511 port map(d,le,lt,bl,output);
    --Tem que trocar essas aspas quando for rodar.
    d <= 	"0000",
            "0001" after 10 ns, 
            "0010" after 20 ns,
            "0011" after 30 ns,
            "0100" after 40 ns,
            "0101" after 50 ns,
            "0110" after 60 ns,
            "0111" after 70 ns,
            "1000" after 80 ns,
            "1001" after 90 ns,
            "0000" after 100 ns;
    lt <= '1',
            '0' after 90 ns;
    bl <= '1',
             '0' after 70 ns;
    le <= '0',
             '1' after 50 ns; 

end test;
