-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 14 (22/05/2021)
-- PS/2 HOST

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture arch of testbench is

	component PS_2_Host is
	port(
    	clk,data: in std_logic;
        ascii: out std_logic_vector(7 downto 0 ));
end component;

	signal clk, data: std_logic;
    signal ascii: std_logic_vector(7 downto 0);
    type matriz is array (5 downto 0) of std_logic_vector (10 downto 0);
    
    signal result: matriz := (
		'0' & x"73"&'1'&'1', -- S
		'0' & x"79"&'1'&'1',-- Y
        '0' &x"73"&'1'&'1', -- S
		'0' &x"74"&'1'&'1', -- T
		'0' &x"65"&'1'&'1', -- E
		'0' &x"6D"&'1'&'1' -- M
		
	);
    signal ps2_data:std_logic_vector(10 downto 0):= (others => '0');
begin
	dut : PS_2_Host port map(clk,data,ascii);
    
process
begin
	
    for f in 5 downto 0 loop
    	for i in 10 downto 0 loop
    	ps2_data<= result(f);
        data <= ps2_data(i);
        clk <= '0';
        wait for 1 ns;
        clk <='1';
        wait for 1 ns;
     	end loop;
     end loop;
    
     wait;
end process;

end arch;