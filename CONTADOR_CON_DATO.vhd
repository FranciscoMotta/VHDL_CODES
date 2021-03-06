LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY CONTADOR_CON_DATO IS 
------------------------------
--DECLARAREMOS LAS VARIABLES
GENERIC(VARIABLE1 : INTEGER := 7);
PORT 
(
RELOJ_DE_ENTRADA, ENABLE: IN STD_LOGIC;
CARGA_PARALELA : IN STD_LOGIC;
CARGA_PARALELA_DATO : IN STD_LOGIC_VECTOR (VARIABLE1 - 1 DOWNTO 0); 
CONTADOR_SALIDA : BUFFER STD_LOGIC_VECTOR (VARIABLE1 - 1 DOWNTO 0)
);
END CONTADOR_CON_DATO;

ARCHITECTURE ARQUI OF CONTADOR_CON_DATO IS 


-------------DECLARACIÃ“N DE COMPONENTES------------
---------------------------------------------------

--DIVISOR DE FRECUENCIA
COMPONENT divisor_50_to_1k IS 
PORT 
( 
SALIDA: BUFFER STD_LOGIC;
CLK_IN: IN STD_LOGIC
);
END COMPONENT;

----------------------------------------------------

------------------SEÃ‘ALES-----------------------
CONSTANT AUMENTO : STD_LOGIC_VECTOR (VARIABLE1 - 1 DOWNTO 0) := (0 => '1', OTHERS => '0');
CONSTANT TOP : STD_LOGIC_VECTOR (VARIABLE1 - 1 DOWNTO 0) := ( OTHERS => '1');
SIGNAL RELOJ_FREQ : STD_LOGIC;
BEGIN

DIVISOR1: divisor_50_to_1k PORT MAP (CLK_IN => RELOJ_DE_ENTRADA, SALIDA => RELOJ_FREQ);

	PROCESS (RELOJ_FREQ, ENABLE, CARGA_PARALELA)
	BEGIN
   
	IF (RELOJ_FREQ'EVENT AND RELOJ_FREQ = '1') THEN 
	
	IF ( ENABLE = '0') THEN 
	
	  CONTADOR_SALIDA <= UNAFFECTED;
		
	ELSIF (ENABLE = '1') THEN
	
	 	 IF (CONTADOR_SALIDA = TOP ) THEN 
		
		 CONTADOR_SALIDA <= NOT TOP;
		
		 ELSE 
		 
		 CONTADOR_SALIDA <= 	CONTADOR_SALIDA + AUMENTO;
		 
	    END IF;
 
	END IF;
	
			IF (CARGA_PARALELA = '0') THEN 
		
				CONTADOR_SALIDA <= UNAFFECTED;
		
				ELSIF (CARGA_PARALELA = '1') THEN
		
				CONTADOR_SALIDA <= CARGA_PARALELA_DATO; 
		
			END IF;
	
	END IF;
	

	
	END PROCESS;

END ARQUI;