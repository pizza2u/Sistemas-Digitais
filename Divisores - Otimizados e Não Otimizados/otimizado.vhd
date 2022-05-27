library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity otimizado is
	port(a,b: in std_logic_vector(7 downto 0);
    	 clk,clr: in std_logic;
         resultado,resto: out std_logic_vector(7 downto 0));
end otimizado;

architecture div of otimizado is

signal dividendo,divisor: std_logic_vector(15 downto 0):=(others => '0');
signal res: std_logic_vector(7 downto 0):=(others => '0');

begin

	process(clr,clk)
    
    variable limit: integer := 8;
    
    begin
    
    if(clr = '1') then
    	dividendo(7 downto 0) <= a;
		dividendo(15 downto 8) <= (others => '0');
		divisor(15 downto 8) <= b;
		divisor(7 downto 0) <= (others => '0');
    	resultado <= (others => '0');
        resto <= (others => '0');
        limit := 0;
    elsif(clk'event and clk = '1') then
    	if(limit <= 8) then
    		divisor(14 downto 0) <= divisor(15 downto 1);
        	divisor(15) <= '0';
			if(divisor > dividendo) then
        		divisor(14 downto 0) <= divisor(15 downto 1);
            	divisor(15) <= '0';
            	res(7 downto 1) <= res(6 downto 0);
            	res(0) <= '0';
        	elsif( dividendo >= divisor) then
        		dividendo <= dividendo - divisor;
        		res(7 downto 1) <= res(6 downto 0);
        		res(0) <= '1';
        	end if;
            limit := limit + 1;
        end if;
    end if;
    
    
	resto <= dividendo(7 downto 0);
    resultado <= res;
        
    end process;


end div;