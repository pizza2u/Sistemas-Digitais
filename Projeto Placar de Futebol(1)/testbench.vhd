-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
--  (05/06/2021)
-- PROJETO - PLACAR DE FUTEBOL
-- O trabalho constitui-se em um placar de futebol com o tempo, tendo então o 1º e 2º tempo, além de um intervalo, implementando também a pontuação de cada time através de entradas com auxílio do double dabble, e uma saída digital indicando o fim do jogo, além de representar o ganhador e o resultado.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity testbench is
end testbench;

architecture test of testbench is

component  timer is
generic(size: integer:= 100);
  Port( 
  		A, B: in std_logic_vector(7 downto 0);
  		clk,clk2,rst : in STD_LOGIC;
  		digit: out integer range 0 to size;
  		AD, AU, BD, BU: OUT STD_LOGIC_VECTOR(0 to 6);
        jogo,result_a,result_b : out std_logic
        );
end timer;


signal  clk,clk2,rst: std_logic := '0';
signal result_a,result_b : std_logic := '0';
signal jogo : std_logic;
signal d: integer;
SIGNAL AAD, AAU, BBD, BBU: STD_LOGIC_VECTOR(0 to 6);
signal A: std_logic_vector(7 downto 0):= "00000000" ;
signal B: std_logic_vector(7 downto 0) := "00000000" ;




begin
dut: timer port map (A,B, clk,clk2, rst, d, AAD, AAU, BBD, BBU,jogo,result_a,result_b);

process
begin
	
    A<= "00001011";
    B<="00000100";
    
    for i in 100 downto 0  loop -- 1º tempo, intervalo e 2º tempo
        clk<='0';
        wait for 10 ps;
        clk<='1';
        wait for 10 ps;
        
       
    end loop;
     clk<='0';
        wait for 10 ps;
        clk<='1';
        wait for 10 ps;
         clk<='0';
        wait for 10 ps;
        clk<='1';
        wait for 10 ps;
    wait;
     
  end process;
  
  process
begin

    
     for i in 40 downto 0  loop 
        clk2<='0';
        wait for 50 ps;
        clk2<='1';
        wait for 50 ps;
        
    end loop;
    
    wait;
    
  end process;

end test;