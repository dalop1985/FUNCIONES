/**************************************************************************************************
* David José de Jesús López Chan	       													      *
* Sistema: Nómina																	    		  *
* Objetivo: Creación de 2 Funciones 					                      *																			  
* ------------------------------------------------------------------------------------------------*
*																						          *
* Versión   Fecha        Usuario            Descripción									          *
* -------   ----------   ------------------ ------------------------------------------- ----------*
*  1.0      21/11/2022   David López	    Creación de 2 Funciones una normal y una con JOINS	  *
**************************************************************************************************/
/*Primera Función*/
USE `nomina`;
DROP function IF EXISTS `divide`;

DELIMITER $$
USE `nomina`$$
CREATE DEFINER=`root`@`localhost` CREATE FUNCTION `divide` (dividendo INT, divisor INT);
RETURNS INT;
NO SQL;
DETERMINISTIC;
BEGIN;
	DECLARE AUX INT;
    DECLARE contador INT;
    DECLARE resto int;
    set contador = 0;
    set aux = 0;
    while (aux + divisor) <= dividendo do
        set aux = aux + divisor ;
        set contador = contador + 1;
    end while;
    set resto = dividendo - aux ;
return contador;
end;


/*División simple*/
USE nomina;
SELECT divide(20,2) as Divide;




/*Segunda Función*/
USE `nomina`;
DROP function IF EXISTS `TOTALCONISR`;

DELIMITER $$
USE `nomina`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `TOTALCONISR` (lim_inf FLOAT, cuota FLOAT, porcentaje FLOAT, id_empleado INT)
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE IMPORTE_ISR FLOAT;
    DECLARE ALTERNOS FLOAT;
    DECLARE TOTAL FLOAT;
    DECLARE QUINCENA FLOAT;
    DECLARE LIM_INFT FLOAT;
    DECLARE PORCT FLOAT;
    SET QUINCENA = (SELECT NOM_SUELDODIARIO * 15 FROM NOMEMPLEADOS WHERE NOM_ID_EMPLEADO = id_empleado);
    SET LIM_INFT = QUINCENA - lim_inf;
    SET PORCT = LIM_INFT * porcentaje;
	SET IMPORTE_ISR = PORCT + cuota;
    SET ALTERNOS = (SELECT SUM(NOM_IMPORTEDEDUCCION) - SUM(NOM_IMPORTEINCIDENCIA) AS RESULT FROM NOMPROCESOS WHERE NOM_IDEMPLEADO = id_empleado);
    SET TOTAL = (QUINCENA - IMPORTE_ISR + ALTERNOS) * -1;
RETURN (TOTAL);
END$$

DELIMITER ;

/*Mandando la info a la sentencia*/
USE nomina;
SELECT TOTALCONISR(2699.41,158.55,10.88,2) as NOMINATOTAL;
