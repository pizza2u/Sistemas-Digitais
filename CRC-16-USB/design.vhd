-- ENGENHARIA ELÉTRICA - IFPB
-- SISTEMAS DIGITAIS 2020.2
-- MINI-PROJETO DA SEMANA 09 (17/04/2021)
-- DESCRIÇÃO DO CRC-16-USB


library IEEE;
use IEEE.std_logic_1164.all;

ENTITY CRC_16_USB IS
  PORT(
    CLK: IN std_logic;-- Sinal de Clock. Para esse projeto, trabalhando em borda de subida.
    DATA_IN: IN std_logic;-- Serial Input.
    CLR: IN std_logic;-- Sinal assíncrono para limpar todos os FFs. Active High
    CRC_OUT: OUT std_logic_vector(15 downto 0);-- Saída paralela dos FFs
    CRC_STATUS: OUT std_logic ); -- ‘1’ quando CRC_OUT for igual à 0, ‘0’ caso contrário.
END CRC_16_USB;

ARCHITECTURE ponyo OF CRC_16_USB IS
	
    SIGNAL CRC: STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    
    BEGIN
    
    CRC_OUT <= CRC;
    CRC_STATUS <= '1' WHEN CRC = x"0000" ELSE '0';
    
    PROCESS(CLK)
    
    	BEGIN
   
        IF(CLR ='1') THEN
            CRC <= (OTHERS => '0'); 
        ELSIF(RISING_EDGE(CLK)) THEN
            FOR I IN 15 DOWNTO 0 LOOP
                IF(I=0) THEN
                    CRC(I) <=  DATA_IN XOR CRC(15);
                ELSIF (I = 2 OR I = 15) THEN
                    CRC(I) <= CRC(I-1) XOR CRC(15);
                ELSE
                    CRC(i) <= CRC(i-1);
                END IF;		
            END LOOP;	
        END IF;

    END PROCESS;

END ponyo;
    