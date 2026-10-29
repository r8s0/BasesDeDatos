# 01 - CONSULTAS INICIALES

# Consultas SQL Graduales para tiendaonline-data.sql

## O. Intro

### Mostrar todas las tablas

```sql
SHOW tables;
```

### Mostrar la estructura de la tabla clientes

```sql
EXPLAIN clientes;
```

## 1. Consultas Básicas

### 1.1. Mostrar todos los clientes registrados

```sql
SELECT * FROM clientes;
```

### 1.2. Mostrar todos los productos disponibles

```sql
SELECT * FROM productos;
```

### 1.3. Mostrar todos los pedidos realizados

```sql
SELECT * FROM pedidos;
```

## 2. Consultas Básicas seleccionando campos específicos

2.1. Mostrar solo el nombre y el email de todos los clientes

```sql
SELECT nombre,email FROM clientes;
```

### 2.2. Mostrar solo el nombre y el precio de todos los productos

```sql
SELECT nombre,precio FROM productos;
```

### 2.3. Mostrar solo el nombre y el estado de todos los pedidos

```sql
SELECT id_pedido,estado FROM pedidos;
```

## 3. Consultas con ORDER BY, SORT y LIMIT

3.1. Mostrar los productos ordenados por precio de mayor a menor

```sql
SELECT * FROM productos ORDER BY precio DESC;
```

### 3.2. Mostrar los pedidos ordenados por fecha de pedido de más reciente a más antigua

```sql
SELECT id_pedido,fecha_pedido FROM pedidos ORDER BY fecha_pedido DESC;
```

### 3.3. Mostrar los 5 primeros clientes registrados

```sql
SELECT * FROM clientes ORDER BY fecha_registro ASC LIMIT 5;
```

### 3.4. Mostrar los 3 últimos pedidos realizados

```sql
SELECT * FROM pedidos ORDER BY fecha_pedido DESC LIMIT 3;
```

## 4. Filtros avanzados (IN, BETWEEN, LIKE...)

### 4.1. Mostrar los productos cuyo precio esté entre 100 y 500 euros

```sql
SELECT * FROM productos WHERE precio BETWEEN 100 AND 500;
```

### 4.2. Mostrar los clientes que sean de España

```sql
SELECT * FROM clientes WHERE pais IN('España');
```

### 4.3. Mostrar los pedidos que tengan un estado que no sea 'pendiente'

```sql
SELECT * FROM pedidos WHERE estado = 'entregado' OR estado = 'enviado' OR estado = 'cancelado';
```

### 4.4. Mostrar los productos cuyo nombre contenga la palabra 'Laptop'

```sql
SELECT nombre FROM productos WHERE nombre LIKE '%Laptop%';
```

### 4.5. Buscar productos cuyo nombre comiencen por 'Laptop' o 'laptop'

```sql
SELECT nombre FROM productos WHERE nombre LIKE 'Laptop%' OR 'laptop%';
```

### 4.6. Mostrar los clientes que tengan un email que contenga '@example.com'

```sql
SELECT * FROM clientes WHERE email LIKE '%@example.com%';
```

### 4.7. Mostrar los productos cuya categoría sea 'Electrónica' o 'Muebles' usando el operador IN

```sql
SELECT * FROM productos WHERE categoria IN('Electrónica','Muebles');
```

### 4.8. Mostrar los pedidos que tengan un total entre 100 y 500 euros

```sql
SELECT * FROM pedidos WHERE coste_total BETWEEN 100 AND 500;
```

## **5. Ejemplos con funciones de cadenas, numéricas y de fechas**

## **Numéricas**

### **5.1. Obtener la longitud del nombre de cada cliente**

```sql
SELECT nombre,CHAR_LENGTH(nombre) AS longitud_nombre
FROM clientes;
```

### **5.2. Obtener el total de pedidos realizados**

```sql
SELECT COUNT(*) AS total_pedidos
FROM pedidos;
```

### **5.3. Obtener el precio promedio de los productos**

```sql
SELECT ROUND(AVG(precio),2) AS precio_promedio
FROM productos;
```

### **5.4. Obtener el precio más bajo de los productos**

```sql
SELECT MIN(precio) AS precio_mas_bajo
FROM productos;
```

### **5.5. Obtener el precio más alto de los productos**

```sql
SELECT MAX(precio) AS precio_mas_alto
FROM productos;
```

### **Funciones de cadena**

### **5.6. Convertir el nombre de los productos a mayúsculas**

```sql
SELECT UPPER(nombre) AS nombre
FROM productos;
```

### **5.7. Convertir el nombre de los clientes a minúsculas**

```sql
SELECT LOWER(nombre) AS nombre
FROM clientes;
```

### **5.8. Obtener los primeros 3 caracteres del nombre de cada producto**

```sql
SELECT nombre,LEFT(nombre,3) AS 3_primeros_caracteres
FROM productos;
```

### **5.9. Obtener los últimos 3 caracteres del nombre de cada producto**

```sql
SELECT nombre,RIGHT(nombre, 3) AS 3_ultimos_caracteres
FROM productos;
```

## **Funciones de fecha**

### **5.10. Obtener la fecha de hoy**

```sql
SELECT CURRENT_DATE() AS fecha_de_hoy;
```

### **5.11. Calcular cuántos días han pasado desde el registro de cada cliente hasta hoy**

```sql
SELECT nombre, TIMESTAMPDIFF(DAY, (fecha_registro), CURRENT_DATE()) AS dias_pasados
FROM clientes;
```