USE ejemplos_tipos_join;
SHOW tables;
EXPLAIN alumnos;
EXPLAIN cursos;
EXPLAIN matriculas;

-- Consulta para comprobar que no salen los alumnos cuyos datos en la tabla no están completos.

SELECT *
FROM alumnos a 
        JOIN matriculas m ON a.id_alumno = m.id_alumno
        JOIN cursos c ON c.id_curso = m.id_curso;
        
-- Para que aparezcan incluso los que no tienen datos completos(tienen huecos):


        
-- Vamos a obtener el listado de alumnos y matriculaciones dejando huecos.

SELECT *
FROM alumnos a
        LEFT JOIN matriculas m ON a.id_alumno = m.id_alumno;

SELECT *
FROM alumnos a
        RIGHT JOIN matriculas m ON a.id_alumno = m.id_alumno;

SELECT *
FROM matriculas m
        LEFT JOIN alumnos a ON a.id_alumno = m.id_alumno;
        
-- *******************************************************TIPOS DE JOIN******************************************************* 
/* LEFT JOIN: coge todo lo que haya a la izquierda y los huecos que contengan en la derecha los rellena con NULL.
   RIGHT JOIN: coge todo lo que haya a la derecha y los huecos que contengan en la izquierda los rellena con NULL.
   INNER JOIN: JOIN normal que no coge ni lo de la derecha ni lo de la izquierda (coge la información común en dos tablas).
   *************************************************************************************************************************** */

-- Vamos con 3 tablas

SELECT *
FROM matriculas m
        LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
        JOIN cursos c ON c.id_curso = m.id_curso;
        -- Salen los alumnos con curso asignado y NO sale el 1005.
SELECT *
FROM matriculas m
        LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
        LEFT JOIN cursos c ON c.id_curso = m.id_curso;
		-- Salen los alumnos con curso asignado y SÍ sale el 1005 que no tiene curso asignado.
SELECT *
FROM matriculas m
        LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
        RIGHT JOIN cursos c ON c.id_curso = m.id_curso;
        -- Salen los cursos con alumnos asignados y los cursos que no tienen asignado ningún alumno.

-- 1) Saca el listado de matrículas en cursos inexistentes.

SELECT *
FROM matriculas m
        LEFT JOIN cursos c ON c.id_curso = m.id_curso
WHERE c.id_curso IS NULL; /* Sirve para solo sacar las líneas donde id_curso es NULL. DEBO ESPECIFICAR ID_CURSO DADO QUE ES AMBIGUO.*/

-- 2) Saca el listado de cursos sin matrículas.

SELECT *
FROM matriculas m
        RIGHT JOIN cursos c ON c.id_curso = m.id_curso
WHERE m.id_curso IS NULL; -- No se puede poner id_curso = null porque no se puede igualar a nada.

-- 3) Alumnos matriculados en cursos inexistentes

SELECT *
FROM alumnos a
        JOIN matriculas m ON m.id_alumno = a.id_alumno
        LEFT JOIN cursos c ON c.id_curso = m.id_curso
WHERE c.id_curso IS NULL;

-- 4) Matrículas de alumnos inexistentes.

SELECT *
FROM matriculas m
        LEFT JOIN alumnos a ON m.id_alumno = a.id_alumno
WHERE a.id_alumno IS NULL;