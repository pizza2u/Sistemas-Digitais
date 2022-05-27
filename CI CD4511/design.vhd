-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;

entity CD4511 is
port(d: in std_logic_vector(3 downto 0);
	  le,lt,bl:in std_logic;
      output:out std_logic_vector(6 downto 0)-- de g ate a--
      );
end entity;

architecture arquitetura of CD4511 is
  begin

    process(d,lt,bl,le)
      begin
          if(lt= '0') then output <= "1111111";

          elsif(bl= '0') then output <= "0000000"; 

          elsif (le = '0') then
              case d is
                when "0000" => output <= "1111110";       
                when "0001" => output <= "0110000";       
                when "0010" => output <= "1101101";       
                when "0011" => output <= "1111001";       
                when "0100" => output <= "0110011";       
                when "0101" => output <= "1011011";       
                when "0110" => output <= "0011111";       
                when "0111" => output <= "1110000";       
                when "1000" => output <= "1111111";       
                when "1001" => output <= "1110011";       

                when others => output <= "0000000";      
              end case;

          else
              output <= output;

           end if;
        end process;

end arquitetura;