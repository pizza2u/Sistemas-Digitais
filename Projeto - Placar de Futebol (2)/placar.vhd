library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
---------- Estrutura Double Dabble
entity placar is

port(TIME_A,TIME_B: in std_logic_vector(7 downto 0);
     clock,reset: in std_logic;
     dezena,unidade: out std_logic_vector(3 downto 0);
     dezena2,unidade2: out std_logic_vector(3 downto 0);
     done: out std_logic);
end placar;

architecture arch of placar is

  signal binaryA : std_logic_vector(19 downto 0);
  signal binaryB : std_logic_vector(19 downto 0);
  
  type states is (idle,check,shift,finish);
  signal state : states := idle;

begin

dezena <= binaryA(15 downto 12);
unidade <= binaryA(11 downto 8);

dezena2 <= binaryB(15 downto 12);
unidade2 <= binaryB(11 downto 8);


 process(reset,clock)
 
    variable contador : integer := 0;
 
  begin
  
   if(reset = '1') then
   
      binaryA <= x"000" & TIME_A;
      binaryB <= x"000" & TIME_B;
      state <= idle;      
      done <= '0';
      contador := 0;
      
   elsif(falling_edge(clock))then
       
       if(state = idle) then
       binaryA <= x"000" & TIME_a;
      binaryB <= x"000" & TIME_B;
      state <= check;
      done <= '0';
      contador := 0;
          
          
       elsif(state = shift) then
        
        binaryA <= binaryA(18 downto 0) & '0';
        binaryB <= binaryB(18 downto 0) & '0';
        contador := contador + 1;
        state<=check;
        
       elsif(state = check) then
       
        if(contador = 8) then
        
          state <= finish;
        
        else
          
           if(binaryA(11 downto 8) >= x"5") then
              
              binaryA(11 downto 8) <= binaryA(11 downto 8) + x"3";
           
           end if;  
           
           if(binaryA(15 downto 12) >= x"5") then
              
              binaryA(15 downto 12) <= binaryA(15 downto 12) + x"3";
           
           end if; 
           
           if(binaryB(11 downto 8) >= x"5") then
              
              binaryB(11 downto 8) <= binaryB(11 downto 8) + x"3";
           
           end if;  
           
           if(binaryB(15 downto 12) >= x"5") then
              
              binaryB(15 downto 12) <= binaryB(15 downto 12) + x"3";
           
           end if; 
           
           state <= shift;
           
         end if;
       
       elsif(state = finish) then
       
         done <= '1';
         
       end if;
    end if;   
    
    
 end process;


end arch;