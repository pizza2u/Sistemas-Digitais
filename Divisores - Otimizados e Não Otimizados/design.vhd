-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 10 
-- 24/04/2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity divisores is
	port(a,b: in std_logic_vector(7 downto 0);
    	 clk,clr: in std_logic;
         resultado1,resultado2: out std_logic_vector(7 downto 0);
         resto1,resto2: out std_logic_vector(7 downto 0));
end divisores;

architecture arch of divisores is

component nao_otimizado is
	port(a,b: in std_logic_vector(7 downto 0);
    	 clk,clr: in std_logic;
         resultado,resto: out std_logic_vector(7 downto 0));
end component;

component otimizado is
	port(a,b: in std_logic_vector(7 downto 0);
    	 clk,clr: in std_logic;
         resultado,resto: out std_logic_vector(7 downto 0));
end component;

signal r1,r2:std_logic_vector(7 downto 0);
signal s1,s2: std_logic_vector(7 downto 0);

begin

dut1: otimizado port map(a,b,clk,clr,r1,s1);
dut2: nao_otimizado port map(a,b,clk,clr,r2,s2);

resultado1 <= r1;
resto1 <= s1;

resultado2 <= r2;
resto2 <= s2;



end arch;