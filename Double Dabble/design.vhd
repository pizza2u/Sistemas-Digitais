library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity doubledabble is

port(binary: in std_logic_vector(7 downto 0);
        reset: in std_logic; --O reset deve ser assíncrono e active-high.
        clk: in std_logic;
        unidade,dezena,centena: out std_logic_vector(3 downto 0);
        done: out std_logic); --O pino done vai para high quando o resultado está pronto e só volta para low depois de um reset.
end doubledabble;

architecture arch of doubledabble is

  type states is (idle,check,shift,finish);
  signal binary2 : std_logic_vector(19 downto 0);
  signal state : states := idle;

begin

	  unidade <= binary2(11 downto 8); 
      dezena <= binary2(15 downto 12);
      centena <= binary2(19 downto 16);

 process(reset,clk)
 
    variable counter : integer := 0;
 
  begin
  
   if(reset = '1') then
   
        binary2 <= x"000" & binary;
        counter := 0;
        state <= check;
        done <= '0';
        state <= idle;
      
   elsif(falling_edge(clk))then 
       if(state = idle) then
          
          state <= check;
          
       elsif(state = shift) then
        
        binary2 <= binary2(18 downto 0) & '0';
        counter := counter + 1;
        state<=check;
       elsif(state = check) then
            if(counter = 8) then
                state <= finish;
            else
                if(binary2(11 downto 8) >= 5) then
                    binary2(11 downto 8) <= binary2(11 downto 8) + x"3";
                end if;
                if(binary2(15 downto 12) >= 5) then
                    binary2(15 downto 12) <= binary2(15 downto 12) + x"3";
                end if;

           
           state <= shift;
           
         end if;
       
       elsif(state = finish) then
       
         done <= '1';
         
       end if;
    end if;   
    
    
 end process;

end arch;