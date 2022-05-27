-- Atividade da 8ª Semana de Sistemas Digitais

-- Miniprojeto CI CD4021B


library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end testbench;

architecture test of testbench is

component CD4021B is

  port(preset: in std_logic_vector(7 downto 0);
       serial, clock, psControl: in std_logic; 
       S6,S7,S8: out std_logic); 

end component;


signal serial, clock, psControl:  std_logic; 

signal S6,S7,S8: std_logic;

signal dados_FFD: std_logic_vector(7 downto 0) := "10101101";

signal preset: std_logic_vector(7 downto 0) := "11101101";

begin

dut: CD4021B port map(dados_FFD, serial, clock, psControl,S6,S7,S8);
    
    
    psControl <= '0',
                 '1' after 5 ns,
                 '0' after 10 ns;
           
 process
   begin  
   
     for i in 0 to 7 loop
       clock <= '0';
       serial <= dados_FFD(i);
     wait for 10 ns;
       clock <='1';
     wait for 10 ns;
   end loop;
   wait;
   end process;           

end test;