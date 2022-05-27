library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity nao_otimizado is
	port(a,b: in std_logic_vector(7 downto 0);
    	 clk,clr: in std_logic;
         resultado,resto: out std_logic_vector(7 downto 0));
end nao_otimizado;

architecture div of nao_otimizado is

signal dividendo,divisor: std_logic_vector(7 downto 0):=(others => '0');
signal slim: std_logic_vector(7 downto 0);

begin

	process(clr,clk)
    
    begin 
    
    if(clr = '1') then
    	dividendo <= a;
		divisor <= b;
        slim <= (others => '0');
    	resultado <= (others => '0');
        resto <= (others => '0');
    elsif(clk'event and clk = '1') then
    	if(dividendo >= divisor) then
        	dividendo <= dividendo - divisor;
            slim <= slim + 1;
        else
        	resto <= dividendo;
            resultado <= slim;
        end if;
    end if;
    
    end process;

end div;