library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity timer is
  generic(size: integer:= 100);
  Port(
  		A, B: in std_logic_vector(7 downto 0);
   		clk,clk2,rst : in STD_LOGIC;
  		digit: out integer range 0 to size;
    	AD, AU, BD, BU: OUT STD_LOGIC_VECTOR(0 to 6);
        jogo,result_a,result_b : out std_logic
	);
end timer;

architecture arch of timer is

component placar is

port(TIME_A,TIME_B: in std_logic_vector(7 downto 0);
     clock,reset: in std_logic;
     dezena,unidade: out std_logic_vector(3 downto 0);
     dezena2,unidade2: out std_logic_vector(3 downto 0);
     done: out std_logic);
     
end component;


component display IS
	
	port(
    enable: in std_logic;
	entrad: in std_logic_vector (3 DOWNTO 0);
   	d: out std_logic_vector(0 to 6) 		
	); 
	
	
END component;

type state is (s1,inter,s2,fim);
signal states : state ;
SIGNAL OK : STD_LOGIC;
SIGNAL AAD, AAU, BBD, BBU: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL enable: STD_LOGIC;
signal teste: std_logic;


begin 
------------------------------------------ Conexões
	x0: placar port map(A, B,clk2, rst,  AAD, AAU, BBD, BBU, OK);  --- Conexão DOUBLE DABBLE
    
    -------------------------- CONEXÃO DISPLAY
    x1: display port map('1', AAD, AD); -- AAD(dezena de A),AAU(Unidade de A)
    x2: display port map(enable, BBD, BD); -- AU,AD,BU,BD( Saída do Display)
    x3:	display port map(enable, AAU, AU);
    x4: display port map(enable, BBU, BU); --BBU(unidade de B), BBD( dezena de B)
 ------------------------------------------------------------------  
    process (clk,rst,jogo) 
    
 		variable temp: integer range 0 to size;
 	 
        
    	begin
      
      	---- Montagem do Contador de acordo com o clock, trabalhando na borda de subida
      
       if(rst='1') then 
			states <= s1;
			temp := 0 ;
            
		elsif (clk'event and clk ='1') then
			
            if(states=inter or states=s1 or states=s2) then
            	temp := temp +1;
                
			end if;
            
            if( states = s1 and temp = 46 ) then -- Primeiro tempo vai até 45 minutos
				states <= inter;
				temp := 0;
               
			elsif (states = inter and temp = 10)  then -- Intervalo vai até 10 minutos
				states <= s2;
				temp := 0;
                
			elsif (states = s2 and temp >= 46 ) then -- Segundo tempo vai até 45 minutos
				states <= fim; 
				temp:= 0;
             
			end if;
           elsif( states = fim) then  --- Sinalizando Fim de Jogo
        	    jogo <= '1';  -- Se o sinal de jogo for a 1, então o jogo terminou
     		      temp := 0;
            else 
            	jogo <= '0'; -- Caso não, ainda continua;
        
         
		end if;
         
         digit<=  temp; 
         
         
          case states is  -- um laço para verificar se permance o lançamento do valor do DD para o Display
      
            when inter => report to_string(temp) severity note;
            WHEN fim => enable <= '0' ;
            when OTHERS => enable <= '1';
         END CASE;
         

       
            end process;
            
--------------------------------------------------------- Sinalizador do Ganhador            
       process( result_a,result_b) 
       	begin
            result_a <= '0';
            result_b <='0';
        if ( A > B) then -- Time A ganhou
        	result_a <= '1';
            result_b <='0';
         	elsif(  A< B) then -- Time B ganhou
            	result_a <= '0';
                result_b <='1';
           	if (B = A) then -- Empate
           		result_a <= '0';
                result_b <='0';
                
             
            end if;
            end if;
            
            end process;
            	
 
 

end arch;
