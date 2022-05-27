-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 10 -  Top level design entity
-- 24/04/2021
-- Sabe-se que o método mais simples, no entanto, consiste em contar quantas vezes podemos subtrair o divisor do dividendo e é conhecido como método das subtrações sucessivas,ou seja, a divisão não otimizada. Com os resultados, pode-se perceber que o divisor não otimizado realizou a operação mais rápido que o otimizado. O otimizado trabalha com a resolução de bits, a resolução ligada aos ciclos de clock, ou seja, vai ter sempre um clock definido, para números grandes, por exemplo, vai levar 8 ciclos de clock caso seja 8 bits. Já na divisão não otimizada, o resto é menor que o dividendo e possui um ponto  que é: consumir mais ciclos de clock quando a diferença dos números (entre dividendo e divisor) é maior.


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture test of testbench is

component divisores is
    port(a,b: in std_logic_vector(7 downto 0);
         clk,clr: in std_logic;
         resultado1,resultado2: out std_logic_vector(7 downto 0);
         resto1,resto2: out std_logic_vector(7 downto 0));
end component;

signal dividendo: std_logic_vector(7 downto 0);
signal divisor: std_logic_vector(7 downto 0);
signal clk,clr: std_logic ;
signal resultado1,resto1: std_logic_vector(7 downto 0);
signal resultado2,resto2: std_logic_vector(7 downto 0);

begin

dut: divisores port map(dividendo,divisor,clk,clr,resultado1,resultado2,resto1,resto2);

    process
    begin
    
    clr<='1' ,
         '0'after 5 ns;
  
  dividendo <= "00001110";
  divisor <="00000011";

    for i in 0 to 30 loop
    	clk<='1';
        wait for 10 ns;
        clk<='0';
        wait for 10 ns;
        
        
     end loop; 
     
    	report "Resultado: divisor otimizado = "& to_string(resultado1) severity note;
        report "Resto: divisor otimizado = "& to_string(resto1) severity note;      
  		report "Resultado: divisor nao otimizado= "& to_string(resultado2) severity note;
        report "Resto: divisor nao otimizado = "& to_string(resto2) severity note;
   
    wait for 10 ns;
	wait;        
    end process;
    
    end;