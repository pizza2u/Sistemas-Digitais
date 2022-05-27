-- psControl= parallel/ serial control

library IEEE;
use IEEE.std_logic_1164.all;

entity CD4021B is
-- O clock é na borda de subida. A entrada serial é barrada
  port(preset: in std_logic_vector(7 downto 0);
       serial, clock, psControl: in std_logic; 
       S6,S7,S8: out std_logic); 

end CD4021B;

architecture arch of CD4021B is

signal dados_FFD: std_logic_vector(7 downto 0) := (others => '0');

begin

    process(psControl, clock)
   begin
   if(psControl = '1') then
     dados_FFD <= not preset;   
   elsif (clock'event and clock='1') then
   
     dados_FFD(7 downto 1) <= dados_FFD(6 downto 0);
     dados_FFD(0) <= serial; -- MSB recebe o serial
   end if;
   
   -- saídas
    S6 <= not dados_FFD(5);
    S7 <= not dados_FFD(6);
    S8 <= not dados_FFD(7); 
    
   
   
   end process;
 
end arch;