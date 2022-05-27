-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 11 (01/05/2021)
-- "PROBLEM 8.3 FROM CIRCUIT DESIGN WITH VHDL"


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY GERADOR IS

PORT(	CLK,STOP,GO: IN STD_LOGIC;
     	UP,DOWN: OUT STD_LOGIC	);
END GERADOR;

ARCHITECTURE ARCH OF GERADOR IS

	TYPE STATES IS (UP_H, UP_L, DOWN_H, DOWN_L);
	SIGNAL UPP, DOW: STD_LOGIC;
	SIGNAL M1: STATES := UP_L;
    SIGNAL M2: STATES := DOWN_L;
   
	BEGIN
	  
	PROCESS(CLK, GO, STOP, M1, M2)
    
    	VARIABLE U, D: INTEGER := 0;
    	
    	BEGIN
        
        -- TIME
        IF(CLK'EVENT) THEN
        	U:=U+1;
            D:=D+1;
  		END IF;

        -- UP
        IF RISING_EDGE(GO) THEN
        	U:=0;
    		M1  <= UP_H;
            report "UP = ALTO";
        ELSIF FALLING_EDGE(GO)	THEN        	
        	M1  <= UP_L;
            report "UP = BAIXO";
        END IF;
        
        CASE M1 IS
			WHEN UP_H => 	IF(U=10) THEN UPP <= '1'; END IF; 	
			WHEN UP_L => 	UPP <= '0';
            WHEN OTHERS => 	UPP <= '0';
		END CASE;
        
        -- DOWN
        IF FALLING_EDGE(STOP) OR FALLING_EDGE(GO)	THEN
        	D:=0;
         	M2  <= DOWN_H;
            report "DOWN = ALTO";
        END IF;
        
        IF RISING_EDGE(STOP) OR RISING_EDGE(GO)	THEN
        	M2  <= DOWN_L; 
            report "DOWN = BAIXO";
        END IF;
        
		CASE M2 IS 		
			WHEN DOWN_H =>	IF(D=10) THEN DOW <= '1'; END IF;
			WHEN DOWN_L => 	DOW <= '0';
            WHEN OTHERS => 	DOW <= '0';
		END CASE;
        
	END PROCESS;
	
    UP <= UPP;
    DOWN <= DOW;
    
END ARCH;
