-- COMPONENTE SHIFT REGISTER HACIA LA DERECHA CON CARGA PARALELA SINCRONA

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--DEFINICION DE LA INTERFAZ
ENTITY shiftregRight_syncLoad IS

GENERIC(		N						: INTEGER	);

PORT
 (
	clk								:  IN  STD_LOGIC;									-- RELOJ DE SHIFT REGISTER
	DataIn							:  IN  STD_LOGIC;									-- SERIAL DATA
   enableShift, enableLoad 	: 	IN  STD_LOGIC;									--	ENTRADAS SHIFT, ENABLE SYNC LOAD RESPECTIVELY
	dataLoad							:  IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);		-- LOADING DATA
	q		  							: 	OUT std_logic_VECTOR(N-1 DOWNTO 0)); 	-- PARALLEL OUTPUTS SHIFT REGISTER

END shiftregRight_syncLoad;
 
architecture shiftregRight_syncLoad of shiftregRight_syncLoad is

signal qaux 		: STD_LOGIC_VECTOR(N-1 DOWNTO 0);

begin 
		
		
		PROCESS (clk)
		
		BEGIN
		
			IF 	(clk'EVENT AND clk='1') THEN
			
				IF (enableLoad = '1') 		THEN
						qaux		<= dataLoad;							-- CARGA PARALELA SINCRONA
						
				ELSIF (enableShift = '1') 	THEN
						qaux		<= DataIn &  qaux(N-1 DOWNTO 1);	-- SHIFT TO THE RIGHT
						
				ELSE
						qaux		<= qaux;									-- PERMANENCIA
						
				END IF;				
			END IF;

		END PROCESS;
		
		--GENERACION DE LA SALIDA
		q 	<= qaux;
		
		
--    OTRA FORMA: SENTENCIA CASE: PREGUNTAR

--    selector <=  enableLoad & enableShift;
--		CASE selector IS
--				WHEN "01" =>
--						qaux	<= DataIn &  qaux(N-1 DOWNTO 1);
--				WHEN "10"	=>
--						qaux	<= dataLoad;
--						
--				WHEN OTHERS	=>
--						qaux  <= "----";
--		END CASE;

 end shiftregRight_syncLoad;