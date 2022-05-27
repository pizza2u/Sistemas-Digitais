library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity cordic is

    port(x1: in std_logic_vector(15 downto 0);
         y1: in std_logic_vector(15 downto 0);
         teta: in std_logic_vector(15 downto 0);
         x2: out std_logic_vector(15 downto 0);
         y2: out std_logic_vector(15 downto 0));
    
end cordic;


architecture pon of cordic is 

    signal x, y: signed (31 downto 0);
    
    type stonk is array (15 downto 0) of signed (15 downto 0);
   
    
    signal lt: stonk := ( x"2d00", x"1a90", x"0e09",x"0720",x"0393",                                  		 x"01ca", x"00e5", x"0072",
    						x"0039", x"001c", x"000e",                             							x"0007",x"0003", x"0001", x"0000", x"0000");
    
	type soluc is array (16 downto 0) of signed(15 downto 0);
     
    signal xn, yn, tg: soluc;
begin

	
    xn(0) <= signed(x1);
    yn(0) <= signed(y1);
    tg(0) <= signed(teta);
    
    x <= xn(15) * x"009d";
	y <= yn(15) * x"009d";

	x2 <= std_logic_vector(x (23 downto 8));
	y2 <= std_logic_vector(y (23 downto 8));
    

    solucao: for i in 0 to 15 generate
		
     	process(tg)
        begin
        
            if (tg(i)(15) = '0') then 

                xn(i+1) <= signed(xn(i)) - shift_right(yn(i), i);
                yn(i+1) <= signed(yn(i)) + shift_right(xn(i), i);
                tg(i+1) <= tg(i) - lt(15 - i);
            else
                xn(i+1) <= signed(xn(i)) + shift_right(yn(i), i);
                yn(i+1) <= signed(yn(i)) - shift_right(xn(i), i);
                tg(i+1) <= tg(i) + lt(15 - i);

            end if;
		end process;
	end generate;    
    
	
    
end pon;