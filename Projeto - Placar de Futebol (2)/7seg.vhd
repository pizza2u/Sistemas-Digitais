library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 ---------- Estrutura do Display de 7 Segmentos
entity display is
	
	port(
    enable: in std_logic;
	entrad: in std_logic_vector (3 DOWNTO 0);
   	d: out std_logic_vector(0 to 6) 		
	); 
	
end display;
 
architecture arch of display is

	begin

	process(entrad) 
		
		begin
        
        IF(enable='1') then
			
			case entrad is
  
        
				when "0000" => d <= "1111110";--7E para 0
				when "0001" => d <= "0110000";--30 para 1
				when "0010" => d <= "1101101"; --6D para 2
				when "0011" => d <= "1111001";--79 para 3
				when "0100" => d <= "0110011";--33 para 4
				when "0101" => d <= "1011011";--5B para 5
				when "0110" => d <= "1011111";--5F para 6
				when "0111" => d <= "1110000";--70 para 7
				when "1000" => d <= "1111111"; --7F para 8
				when "1001" => d <= "1111011";--73 para 9
				when others => d <= "0000000"; --0  para outros
				
			end case;
		
        else
        	d <= "0000000";
        END IF;
        
	END PROCESS;
	
END arch;