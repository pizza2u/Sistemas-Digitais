-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 09 (17/04/2021)
-- DESCRIÇÃO DO CRC-16-USB


library IEEE;
use IEEE.std_logic_1164.all;
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.NUMERIC_STD.ALL;

ENTITY testbench IS END testbench;

ARCHITECTURE test OF testbench IS

    COMPONENT CRC_16_USB IS
      PORT(
        CLK: IN std_logic;
        DATA_IN: IN std_logic;
        CLR: IN std_logic;
        CRC_OUT: OUT std_logic_vector(15 DOWNTO 0);
        CRC_STATUS: OUT std_logic);
    END COMPONENT;

	SIGNAL CLOCK, SERIAL, RESET, CRC_OK: STD_LOGIC;
    SIGNAL CRC: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL DATA: STD_LOGIC_VECTOR(31 downto 0);
    
	BEGIN
    
	X: CRC_16_USB PORT MAP(CLOCK, SERIAL, RESET, CRC, CRC_OK);
    
   	PROCESS
    
      	BEGIN
      
      	DATA <= STD_LOGIC_VECTOR(TO_UNSIGNED(15, 16)) & x"0000";
        
        RESET <= '1', '0' AFTER 20 NS;
      
        FOR I IN 31 DOWNTO 0 LOOP 
          	SERIAL <= DATA(I);
          	CLOCK <= '1';
        	WAIT FOR 10 NS;
        	CLOCK <= '0';
  			WAIT FOR 10 ns;
    	END LOOP;
        
        WAIT FOR 10 NS;
        RESET <= '1', '0' AFTER 20 NS;
        
        REPORT "1 - rpm = " & to_string(data(31 downto 16)) SEVERITY NOTE;
        REPORT "1 - Gerando CRC = " & to_string(CRC) SEVERITY NOTE;
        
      	DATA(15 DOWNTO 0) <= CRC;

        FOR I IN 31 DOWNTO 0 LOOP 
            CLOCK <= '1';
            SERIAL <= DATA(I);
            WAIT FOR 10 NS;
            CLOCK <= '0';
            WAIT FOR 10 NS;
        END LOOP;

        WAIT FOR 10 NS; 

    	REPORT "1 - Verificando CRC = " & to_string(DATA) SEVERITY NOTE; 
        ASSERT CRC_OK = '0' report "INTEGRO" SEVERITY NOTE;
        ASSERT CRC_OK = '1' report "CORROMPIDO"  SEVERITY NOTE;
        
        RESET <= '1', '0' AFTER 20 NS;
        
        -----------------------------------------------------------------
        
        DATA <= "10101110000100010000000000000000";
        RESET <= '1', '0' AFTER 20 NS;
      
        FOR I IN 31 DOWNTO 0 LOOP 
          	SERIAL <= DATA(I);
          	CLOCK <= '1';
        	WAIT FOR 10 NS;
        	CLOCK <= '0';
  			WAIT FOR 10 ns;
    	END LOOP;
        
        WAIT FOR 10 NS;
        RESET <= '1', '0' AFTER 20 NS;
        
        REPORT "2 - Gerando CRC = " & to_string(CRC) SEVERITY NOTE;
        
      	DATA(15 DOWNTO 0) <= CRC;

        FOR I IN 31 DOWNTO 0 LOOP 
            CLOCK <= '1';
            SERIAL <= DATA(I);
            WAIT FOR 10 NS;
            CLOCK <= '0';
            WAIT FOR 10 NS;
        END LOOP;

        WAIT FOR 10 NS; 

    	REPORT "2 - Verificando CRC = " & to_string(DATA) SEVERITY NOTE; 
        ASSERT CRC_OK = '0' report "INTEGRO" SEVERITY NOTE;
        ASSERT CRC_OK = '1' report "CORROMPIDO"  SEVERITY NOTE;
        
        RESET <= '1', '0' AFTER 20 NS;
        
        -----------------------------------------------------------------
        
        DATA <= "10001110000100110000000000000000";
        RESET <= '1', '0' AFTER 20 NS;
      
        FOR I IN 31 DOWNTO 0 LOOP 
          	SERIAL <= DATA(I);
          	CLOCK <= '1';
        	WAIT FOR 10 NS;
        	CLOCK <= '0';
  			WAIT FOR 10 ns;
    	END LOOP;
        
        WAIT FOR 10 NS;
        RESET <= '1', '0' AFTER 20 NS;
        
        REPORT "3 - Gerando CRC = " & to_string(CRC) SEVERITY NOTE;
        
      	DATA(15 DOWNTO 0) <= CRC;

        FOR I IN 31 DOWNTO 0 LOOP 
            CLOCK <= '1';
            SERIAL <= DATA(I);
            WAIT FOR 10 NS;
            CLOCK <= '0';
            WAIT FOR 10 NS;
        END LOOP;

        WAIT FOR 10 NS; 

    	REPORT "3 - Verificando CRC = " & to_string(DATA) SEVERITY NOTE; 
        ASSERT CRC_OK = '0' report "INTEGRO" SEVERITY NOTE;
        ASSERT CRC_OK = '1' report "CORROMPIDO"  SEVERITY NOTE;
        
        RESET <= '1', '0' AFTER 20 NS;
        
        -----------------------------------------------------------------
        
        DATA <= "11111111111111110000000000000000";
        RESET <= '1', '0' AFTER 20 NS;
      
        FOR I IN 31 DOWNTO 0 LOOP 
          	SERIAL <= DATA(I);
          	CLOCK <= '1';
        	WAIT FOR 10 NS;
        	CLOCK <= '0';
  			WAIT FOR 10 ns;
    	END LOOP;
        
        WAIT FOR 10 NS;
        RESET <= '1', '0' AFTER 20 NS;
        
        REPORT "4 - Gerando CRC = " & to_string(CRC) SEVERITY NOTE;
        
      	DATA(15 DOWNTO 0) <= CRC;

        FOR I IN 31 DOWNTO 0 LOOP 
            CLOCK <= '1';
            SERIAL <= DATA(I);
            WAIT FOR 10 NS;
            CLOCK <= '0';
            WAIT FOR 10 NS;
        END LOOP;

        WAIT FOR 10 NS; 

    	REPORT "4 - Verificando CRC = " & to_string(DATA) SEVERITY NOTE; 
        ASSERT CRC_OK = '0' report "INTEGRO" SEVERITY NOTE;
        ASSERT CRC_OK = '1' report "CORROMPIDO"  SEVERITY NOTE;
        
        RESET <= '1', '0' AFTER 20 NS;
        
        ------------------------ TESTE DE FALHA ------------------------------
        
        DATA <= "10101010110010010000000000000000";
        RESET <= '1', '0' AFTER 20 NS;
      
        FOR I IN 31 DOWNTO 0 LOOP 
          	SERIAL <= DATA(I);
          	CLOCK <= '1';
        	WAIT FOR 10 NS;
        	CLOCK <= '0';
  			WAIT FOR 10 ns;
    	END LOOP;
        
        WAIT FOR 10 NS;
        RESET <= '1', '0' AFTER 20 NS;
        
        REPORT "5 - Gerando CRC = " & to_string(CRC) SEVERITY NOTE;
        
      	DATA(15 DOWNTO 0) <= "1010101010101010"; --CRC;

        FOR I IN 31 DOWNTO 0 LOOP 
            CLOCK <= '1';
            SERIAL <= DATA(I);
            WAIT FOR 10 NS;
            CLOCK <= '0';
            WAIT FOR 10 NS;
        END LOOP;

        WAIT FOR 10 NS; 

    	REPORT "5 - Verificando CRC = " & to_string(DATA) SEVERITY NOTE; 
        ASSERT CRC_OK = '0' report "INTEGRO" SEVERITY NOTE;
        ASSERT CRC_OK = '1' report "CORROMPIDO"  SEVERITY NOTE;
        
        RESET <= '1', '0' AFTER 20 NS;
        
        -----------------------------------------------------------------
        
        WAIT; 
    
    END PROCESS;      

END test;

