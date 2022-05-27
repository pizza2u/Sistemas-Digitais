-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 11 (01/05/2021)
-- "PROBLEM 8.2 FROM CIRCUIT DESIGN WITH VHDL"

library IEEE;
use IEEE.std_logic_1164.all;

ENTITY QUESTAO8_2 IS
	PORT(clock: in std_logic;
         OUT1, OUT2 :  out std_logic);
end QUESTAO8_2;

ARCHITECTURE BOSS OF QUESTAO8_2 IS

	TYPE state is (one,two,three,four,five,six,seven,eight);
	SIGNAL CURRENT_STATE1, NEXT_STATE1, CURRENT_STATE2, NEXT_STATE2: state;

	BEGIN

	PROCESS(clock)
	    BEGIN
		IF(clock'event) THEN
			IF clock = '1' THEN	CURRENT_STATE1<= NEXT_STATE1; END IF;
	      	CURRENT_STATE2 <= NEXT_STATE2;
	    END IF;
        
        report "Estado de Saida 1 = " & std_logic'image (OUT1) & 
        	   "Estado de Saida 2 = " & std_logic'image (OUT2);
        
	END PROCESS;
	
	PROCESS(CURRENT_STATE1)
	    BEGIN
        report "Estado da Maquina 1 = " & TO_STRING(CURRENT_STATE1);
		CASE CURRENT_STATE1 IS
	        WHEN one => 	NEXT_STATE1 <= two; 	OUT1<='0';
			WHEN two => 	NEXT_STATE1 <= three; 	OUT1<='1';
			WHEN three => 	NEXT_STATE1 <= four; 	OUT1<='0';
			WHEN four => 	NEXT_STATE1 <= one; 	OUT1<='0';
	        WHEN OTHERS => 	NEXT_STATE1 <= CURRENT_STATE1;  
	    END CASE;        
	END PROCESS;
	
	PROCESS(CURRENT_STATE2)
	 	BEGIN
        report "Estado da Maquina 2 = " & TO_STRING(CURRENT_STATE2);
		CASE CURRENT_STATE2 IS
			WHEN one => 	NEXT_STATE2 <= two; 	OUT2 <= '0';
			WHEN two => 	NEXT_STATE2 <= three; 	OUT2 <= '1';
			WHEN three => 	NEXT_STATE2 <= four; 	OUT2 <= '1';
			WHEN four => 	NEXT_STATE2 <= five; 	OUT2 <= '0';
			WHEN five => 	NEXT_STATE2 <= six; 	OUT2 <= '1';
			WHEN six => 	NEXT_STATE2 <= seven; 	OUT2 <= '0';
			WHEN seven => 	NEXT_STATE2 <= eight; 	OUT2 <= '0';
			WHEN eight => 	NEXT_STATE2 <= one; 	OUT2 <= '0';
	        WHEN others => 	NEXT_STATE2 <= CURRENT_STATE2;        
		END CASE;
	END PROCESS;

END BOSS;
