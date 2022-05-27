library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PS_2_Host is
	port(
    	clk,data: in std_logic;
        ascii: out std_logic_vector(7 downto 0 ));
end PS_2_Host;

architecture arch of PS_2_Host is

	type states is (shift,reset, fim);
    signal  state : states;
	signal data2: std_logic_vector(9 downto 0) := (others => '0');
    signal counter : integer range 0 to 9 := 0;
    signal a: std_logic_vector (7 downto 0):= (others => '0');
 begin    
 
    process(clk)
    begin
    	
    	if(falling_edge(clk)) then
        	if(falling_edge(data) and counter = 0) then
            	state <= shift;
             elsif(counter = 8) then
             	state <= reset;
              elsif(counter = 9) then
              	state <= fim;
              end if;
              
             case state is
				when shift => data2 <= (data2(8 downto 0) & data);
                    counter <= counter+1; 
				when reset =>	counter <= 0;
               	a <= data2(8 downto 1);
				when others => report "fim" severity note;
        	end case;
           
           end if;

    end process;
    process(a)
    	begin
     case a is

        			when x"73" => ascii <= x"1B"; 	-- s
        		    when x"79" => ascii <= x"35"; 	-- y
        		    when x"74" => ascii <= x"2C";	--t
        		    when x"65" => ascii <= x"24";  -- e
        		    when x"6D" => ascii <= x"3A";	-- m
            	    when others => ascii <= x"FF";
        		end case ;
      
      end process;
    
      
  end arch;
