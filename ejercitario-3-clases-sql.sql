-- salario está dado por posicion y asignacion de categoria vigente para esa posicion. Ambas tienen fecha_fin = null
-- tomando como base la lista de empleados, verificar cual es el salario max, min y promedio
-- Formatear salida para que se muestren los puntos de mil
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min,
    to_char(avg(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
-- basado en la consulta anterior, determine la mayor y menor asignacion en cada area
-- la consulta tendrá nombre de area, asignacion max, asignacion min
select a.nombre_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
join b_areas a
    on p.id_area = a.id
    group by a.nombre_area;
-- determinar el nombre y apellido, nombre de categoria, asignacion y area del empleado (o empleados) con la asignacion maxima vigente
-- probar con un subquery normal, y luego con la clausula with
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
-- determinar nombre, apellido, nombre de categoria, asignacion y area de empleados que tienen una asignación inferior al promedio
-- ordenar por asignacion en forma descendente
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion DESC;
-- obtener cantidad de clientes que hay por localidad. Tener en cuenta en tabla b_personas solo aquellas que son clientes
-- listar id, descripcion de localidad y cantidad de clientes. Asegurarsszse de que se listen las localidades que no tienen clientes
select l.id, l.nombre, count(p.id) cant_clientes
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad
group by l.id, l.nombre
order by 1;
-- listar el volumen y monto de compras y ventas que se hicieron por cada articulo durante el año 2011
-- debe listar tambien los articulos que no tuvieron movimiento
-- mostrar datos: id_articulo, nombre_articulo, cant_compras, monto_compras, cant_ventas, monto_ventas

    
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
join b_localidad l
    on c.id_localidad = l.id;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
left outer join b_localidad l
    on c.id_localidad = l.id;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
right outer join b_localidad l
    on c.id_localidad = l.id;
select l.id, l.nombre, count(p.id)
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad
group by l.id, l.nombre
order by 1;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
right outer join b_localidad l
    on c.id_localidad = l.id;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
left outer join b_localidad l
    on c.id_localidad = l.id;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
join b_localidad l
    on c.id_localidad = l.id;
-- salario está dado por posicion y asignacion de categoria vigente para esa posicion. Ambas tienen fecha_fin = null
-- tomando como base la lista de empleados, verificar cual es el salario max, min y promedio
-- Formatear salida para que se muestren los puntos de mil
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min,
    to_char(avg(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
-- basado en la consulta anterior, determine la mayor y menor asignacion en cada area
-- la consulta tendrá nombre de area, asignacion max, asignacion min
select a.nombre_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
join b_areas a
    on p.id_area = a.id
    group by a.nombre_area;
-- determinar el nombre y apellido, nombre de categoria, asignacion y area del empleado (o empleados) con la asignacion maxima vigente
-- probar con un subquery normal, y luego con la clausula with
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
-- determinar nombre, apellido, nombre de categoria, asignacion y area de empleados que tienen una asignación inferior al promedio
-- ordenar por asignacion en forma descendente
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion DESC;
-- obtener cantidad de clientes que hay por localidad. Tener en cuenta en tabla b_personas solo aquellas que son clientes
-- listar id, descripcion de localidad y cantidad de clientes. Asegurarsszse de que se listen las localidades que no tienen clientes
select l.id, l.nombre, count(p.id) cant_clientes
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad
group by l.id, l.nombre
order by 1;
-- listar el volumen y monto de compras y ventas que se hicieron por cada articulo durante el año 2011
-- debe listar tambien los articulos que no tuvieron movimiento
-- mostrar datos: id_articulo, nombre_articulo, cant_compras, monto_compras, cant_ventas, monto_ventas

    
select l.id, l.nombre
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion DESC;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null);
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select min(asignacion) from b_categorias_salariales where fecha_fin is null);
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
with asignacion as
(select max(c.asignacion) from b_categorias_salariales c where fecha_fin is null)
select e.nombre, e.apellido, c.nombre_cat, asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and asignacion = c.asignacion;
with asignacion as
(select max(c.asignacion) from b_categorias_salariales c where fecha_fin is null)
select e.nombre, e.apellido, c.nombre_cat, asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id;
with asignacion as
(select max(asignacion) from b_categorias_salariales where fecha_fin is null)
select e.nombre, e.apellido, c.nombre_cat, asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
select e.nombre, e.apellido, c.nombre_cat, (select max(asignacion) from b_categorias_salariales) salario
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    where p.fecha_fin is null;
select e.nombre, e.apellido
from b_posicion_actual p
    join b_empleados e on p.cedula = e.cedula where p.fecha_fin is null;
select a.nombre_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
join b_areas a
    on p.id_area = a.id
    group by a.nombre_area;
select p.id_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
    group by p.id_area;
select id_venta, numero_cuota, to_char(monto_cuota, '99G999G999G9999', 'NLS_NUMERIC_CHARACTERS="."') as monto_cuota
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select id_venta, numero_cuota, monto_cuota
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select *from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail%' or correo_electronico like '%@gmail%';
select to_char(max(c.asignacion), '9g999g999','NLS_NUMERIC_CHARACTERS="."')  as salario_max, min(c.asignacion) as salario_min, avg(c.asignacion) as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
select DISTINCT precio from b_articulos;
file:/home/jvillagra/Downloads/BD2/SCRIPT CREACION ESQUEMA/SCRIPT CREACION ESQUEMA/02_CREATAB_ESP_NEW.SQL
select * from b_personas;
SELECT text  FROM user_views WHERE view_name = 'V_VISTA';
select e.cedula, v.monto_total
from b_ventas v
inner join b_empleados e
    on v.cedula_vendedor = e.cedula
group by e.cedula, v.monto_total;
select id_venta, numero_cuota, to_char(monto_cuota, '99G999G999G9999', 'NLS_NUMERIC_CHARACTERS="."')
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail.com' or correo_electronico like '%@gmail.com';
select id_venta, numero_cuota, to_char(monto_cuota, 9.999999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select id_venta, numero_cuota,to_char(monto_cuota, 999.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY');
select id_venta, numero_cuota, to_char(monto_cuota, '9G999G999', 'NLS_NUMERIC_CHARACTERS="."') as monto_cuota
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail%' or correo_electronico like '%@gmail%';
CREATE OR REPLACE VIEW "V_VISTA"
AS SELECT COD_CATEGORIA
FROM B_CATEGORIAS_SALARIALES WHERE UPPER(NOMBRE_CAT) like 'GERENCIA%';
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%hotmail%' || '%gmail%';
alter table LEGAJO
    add constraint fk_cedula_legajo foreign key (CEDULA) references B_EMPLEADOS;
alter table LEGAJO
    add constraint pk_legajo primary key (ID);
alter table LEGAJO
    add constraint ck_tipo_evento check (TIPO_EVENTO in ('PJ', 'CI', 'CE', 'SP', 'VC'));
select e.cedula from b_empleados e
    join b_ventas v
    on e.cedula = v.cedula_vendedor;
SELECT A.ID, A.NOMBRE, COM.CANTIDAD COMPRAS, COM.MONTO MONTO_COMPRAS, VEN.CANTIDAD VENTAS, VEN.MONTO MONTO_VENTAS
FROM B_ARTICULOS A 
LEFT OUTER JOIN (SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO_COMPRA) MONTO
                    FROM B_DETALLE_COMPRAS D
                    JOIN B_COMPRAS C ON C.ID = D.ID_COMPRA
                    WHERE C.FECHA LIKE '%11'
                    GROUP BY D.ID_ARTICULO) COM ON COM.ID_ARTICULO = A.ID
LEFT OUTER JOIN (SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO) MONTO
                    FROM B_DETALLE_VENTAS D
                    JOIN B_VENTAS V ON V.ID = D.ID_VENTA
                    WHERE V.FECHA LIKE '%11'
                    GROUP BY D.ID_ARTICULO) VEN ON VEN.ID_ARTICULO = A.ID;
create table ASISTENCIA (
	ID				NUMBER(12) NULL,
	CEDULA			NUMBER(11) NOT NULL,
	HORA_ENTRADA	DATE NOT NULL,
	HORA_SALIDA		DATE NULL
);
alter table ASISTENCIA
    add constraint ck_fecha check ((HORA_SALIDA IS NULL) OR (HORA_SALIDA > HORA_ENTRADA) AND TRUNC(HORA_SALIDA) = TRUNC(HORA_ENTRADA));
alter table ASISTENCIA
    add constraint fk_cedula_asistencia foreign key (CEDULA) REFERENCES B_EMPLEADOS;
alter table ASISTENCIA
    add constraint pk_asistencia PRIMARY KEY (ID);
create table DEPENDIENTES(
    CEDULA_DEPEN        NUMBER(11) NOT NULL,
    CEDULA              NUMBER(11) NOT NULL,
    NOMBRE              VARCHAR2(40) NOT NULL,
    APELLIDO            VARCHAR2(40) NOT NULL,
    FECHA_NACIMIENTO    DATE NOT NULL,
    FECHA_ACTUALIZ      DATE NULL
);
alter table DEPENDIENTES
    add constraint fk_cedula_dependientes foreign key (CEDULA) references B_EMPLEADOS;
alter table DEPENDIENTES
    add constraint pk_dependientes PRIMARY KEY (CEDULA_DEPEN, CEDULA);
create table LEGAJO(
    ID                      NUMBER(8) NULL,
    DESCRIPCION_EVENTO      VARCHAR2(500) NOT NULL,
    TIPO_EVENTO             VARCHAR2(2) NOT NULL,
    FECHA_EVENTO            DATE NOT NULL,
    DURACION                NUMBER(3) NOT NULL,
    CEDULA                  NUMBER(11) NOT NULL
);
alter table LEGAJO
    add constraint fk_cedula_legajo foreign key (CEDULA) references B_EMPLEADOS;
alter table LEGAJO
    add constraint pk_legajo primary key (ID);
alter table LEGAJO
    add constraint ck_tipo_evento check (TIPO_EVENTO in ('PJ', 'CI', 'CE', 'SP', 'VC'));

create sequence SEC_ASISTENCIA start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;

create sequence SEC_LEGAJO start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;

create or replace function f_fibonacci
    (pos in number)
    return number
is
begin
    if(pos < 2) then
        return 1;
    end if;
    return (f_fibonacci(pos - 2)+f_fibonacci(pos-1));
end;
/

declare
    resultado number :=0;
begin
    resultado := f_fibonacci(6);
    dbms_output.put_line(resultado);
end;
/

create user BASEDATOS2 identified by BASEDATOS2	
       DEFAULT TABLESPACE BASEDATOS2
       TEMPORARY TABLESPACE TEMP;
GRANT DBA TO BASEDATOS2 WITH ADMIN OPTION;



select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F';
select e.cedula, SUM((dv.cantidad*dv.precio)) as ventas_empleado, v.monto_total
from b_detalle_ventas dv 
inner join b_ventas v 
    on dv.id_venta = v.id
inner join b_empleados e
    on v.cedula_vendedor = e.cedula
group by e.cedula, v.monto_total;
WITH 
compras AS
(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO_COMPRA) MONTO
FROM B_DETALLE_COMPRAS D JOIN B_COMPRAS C
ON    C.ID = D.ID_COMPRA
WHERE  C.FECHA LIKE '%11'
GROUP BY  D.ID_ARTICULO),
ventas AS
(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO) MONTO
FROM B_DETALLE_VENTAS D JOIN B_VENTAS V
ON    V.ID = D.ID_VENTA
WHERE V.FECHA LIKE '%11'
GROUP BY  D.ID_ARTICULO) 
SELECT A.ID, A.NOMBRE, COM.CANTIDAD COMPRAS , COM.MONTO MONTO_COMPRAS, 
VEN.CANTIDAD VENTAS, VEN.MONTO MONTO_VENTAS
FROM B_ARTICULOS A LEFT OUTER JOIN compras COM
ON COM.ID_ARTICULO = A.ID
LEFT OUTER JOIN ventas VEN
ON VEN.ID_ARTICULO = A.ID;
CREATE OR REPLACE VIEW V_MAX_A AS
SELECT e.nombre||' '||e.apellido nombre, S.NOMBRE_CAT nombrecat, S.ASIGNACION asig, A.NOMBRE_AREA areas
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
AND S.ASIGNACION = (
SELECT MAX(S.ASIGNACION)
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL);
create table ASISTENCIA (
	ID				NUMBER(12) NULL,
	CEDULA			NUMBER(11) NOT NULL,
	HORA_ENTRADA	DATE NOT NULL,
	HORA_SALIDA		DATE NULL
);
alter table ASISTENCIA
    add constraint ck_fecha check (HORA_SALIDA IS NULL) OR (HORA_SALIDA > HORA_ENTRADA) AND TRUNC(HORA_SALIDA) > TRUNC(HORA_ENTRADA);
alter table ASISTENCIA
    add constraint fk_cedula_asistencia foreign key (CEDULA) REFERENCES B_EMPLEADOS;
drop table ASISTENCIA;

drop table LEGAJO;

drop table DEPENDIENTES;
CREATE MATERIALIZED VIEW V_LIQUIDACION
REFRESH START WITH TRUNC(LAST_DAY(SYSDATE)) NEXT TRUNC(ADD_MONTHS(LAST_DAY(SYSDATE), 1))
AS
SELECT P.CEDULA, S.ASIGNACION SALARIO_BASICO, S.ASIGNACION*0.9 DESCUENTO_IPS,
V.BONIF_VENTAS, S.DURACION SUSPENSIONES
FROM
B_POSICION_ACTUAL P
JOIN B_CATEGORIAS_SALARIALES S ON S.COD_CATEGORIA = P.COD_CATEGORIA
LEFT OUTER JOIN
(SELECT V.CEDULA_VENDEDOR,
SUM(D.PRECIO*D.CANTIDAD*A.PORC_COMISION) BONIF_VENTAS
FROM
B_VENTAS V JOIN B_DETALLE_VENTAS D ON V.ID = D.ID_VENTA
JOIN B_ARTICULOS A ON A.ID = D.ID_ARTICULO
WHERE EXTRACT (MONTH FROM V.FECHA) = EXTRACT (MONTH FROM SYSDATE)
AND
EXTRACT (YEAR FROM V.FECHA) = EXTRACT (YEAR FROM SYSDATE)
GROUP BY V.CEDULA_VENDEDOR) V
ON V.CEDULA_VENDEDOR = P.CEDULA
LEFT OUTER JOIN (SELECT CEDULA, SUM(DURACION) DURACION
FROM LEGAJO
WHERE TIPO_EVENTO = 'SP'
AND EXTRACT (MONTH FROM FECHA_EVENTO) = EXTRACT (MONTH FROM SYSDATE)
AND EXTRACT (YEAR FROM FECHA_EVENTO) = EXTRACT (YEAR FROM SYSDATE)
GROUP BY CEDULA) S
ON S.CEDULA = P.CEDULA
WHERE
S.FECHA_FIN IS NULL
AND
P.FECHA_FIN IS NULL;
SELECT /* +FIRST_ROWS */ * FROM b_personas WHERE id_localidad IN (SELECT id FROM b_localidad WHERE UPPER(nombre) = 'ASUNCION');
select a.id, a.nombre, a.unidad_medida, a.precio, a.porc_comision, (dv.cantidad * a.precio) as sub_total, ((dv.cantidad * a.precio) * a.porc_comision) as comision
from b_articulos a
    join b_detalle_ventas dv
        on a.id = dv.id_articulo;
TRUNCATE TABLE B_AREAS_NUEVA;
select * from b_articulos;
select * from b_empleados;
CREATE OR REPLACE VIEW V_MAX AS
    SELECT e.nombre||' '||e.apellido NOMBRE, S.NOMBRE_CAT CATEGORIA, A.NOMBRE_AREA AREA, MAX(S.ASIGNACION) ASIGNACION
    FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
    WHERE A.ID = P.ID_AREA AND E.CEDULA = P.CEDULA
        AND S.COD_CATEGORIA = P.COD_CATEGORIA
        AND S.FECHA_FIN IS NULL
        AND P.FECHA_FIN IS NULL
    GROUP BY e.nombre||' '||e.apellido, S.NOMBRE_CAT, A.NOMBRE_AREA;
select SUM((dv.cantidad*dv.precio)) as ventas_empleado
from b_detalle_ventas dv 
inner join b_ventas v 
    on dv.id_venta = v.id
inner join b_empleados e
    on v.cedula_vendedor = e.cedula;
create or replace function f_obtener_salario(pcedula number)
  return number is
  v_salario number;
begin
  select c.asignacion into v_salario
  from b_posicion_actual p join b_categorias_salariales c
  on c.cod_categoria = p.cod_categoria
  where
  p.cedula = pcedula
  and p.fecha_fin is null
  and c.fecha_fin is null;
  return v_salario;
exception
  when no_data_found then
    return -1;
end;/
select v.cedula_vendedor, SUM((dv.cantidad*dv.precio)) as ventas_empleado
from b_detalle_ventas dv 
inner join b_ventas v on dv.id_venta= v.id
group by v.cedula_vendedor;
 CREATE TABLE b_areas_nueva AS SELECT b.id, b.nombre_area, b.fecha_crea, b.activa, b.id_area_superior FROM b_areas b;
ALTER SESSION set "_ORACLE_SCRIPT"=true;
select * from b_personas
where tipo_persona='F'
    and (correo_electronico like '%@hotmail%' or correo_electronico like '%@gmail%');
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."')  as salario_max, min(c.asignacion) as salario_min, avg(c.asignacion) as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
CREATE OR REPLACE VIEW V_MAX AS
SELECT e.nombre||' '||e.apellido nombre, S.NOMBRE_CAT nombrecat, S.ASIGNACION asig, A.NOMBRE_AREA areas
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
AND S.ASIGNACION = (
SELECT MAX(S.ASIGNACION) asi
FROM B_CATEGORIAS_SALARIALES S);
select id_venta, numero_cuota,to_char(monto_cuota, 9.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY');
select id_venta, numero_cuota, to_char(monto_cuota, 999.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY');
WITH compras AS (SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD*D.PRECIO_COMPRA) MONTO
                FROM B_DETALLE_COMPRAS D
                JOIN B_COMPRAS C ON C.ID = D.ID_COMPRA
                WHERE C.FECHA LIKE '%11' GROUP BY D.ID_ARTICULO),
ventas AS(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO) MONTO
                FROM B_DETALLE_VENTAS D
                JOIN B_VENTAS V ON V.ID = D.ID_VENTA
                WHERE V.FECHA LIKE '%11'
                GROUP BY D.ID_ARTICULO)
SELECT A.ID, A.NOMBRE, COM.CANTIDAD COMPRA, COM.MONTO MONTO_COMPRAS, VEN.CANTIDAD VENTAS, VEN.MONTO MONTO_VENTAS
FROM B_ARTICULOS A
LEFT OUTER JOIN compras COM ON COM.ID_ARTICULO = A.ID
LEFT OUTER JOIN ventas VEN ON VEN.ID_ARTICULO = A.ID;
alter table ASISTENCIA
    add constraint pk_asistencia PRIMARY KEY (ID);
create table DEPENDIENTES(
    CEDULA_DEPEN        NUMBER(11) NOT NULL,
    CEDULA              NUMBER(11) NOT NULL,
    NOMBRE              VARCHAR2(40) NOT NULL,
    APELLIDO            VARCHAR2(40) NOT NULL,
    FECHA_NACIMIENTO    DATE NOT NULL,
    FECHA_ACTUALIZ      DATE NULL
);
alter table DEPENDIENTES
    add constraint fk_cedula_dependientes foreign key (CEDULA) references B_EMPLEADOS;
alter table DEPENDIENTES
    add constraint pk_dependientes PRIMARY KEY (CEDULA_DEPEN, CEDULA);
create table LEGAJO(
    ID                      NUMBER(8) NULL,
    DESCRIPCION_EVENTO      VARCHAR2(500) NOT NULL,
    TIPO_EVENTO             VARCHAR2(2) NOT NULL,
    FECHA_EVENTO            DATE NOT NULL
    DURACION                NUMBER(3) NOT NULL
    CEDULA                  NUMBER(11) NOT NULL
)
alter table LEGAJO
    add constraint fk_cedula_legajo foreign key (CEDULA) references B_EMPLEADOS;
alter table LEGAJO
    add constraint pk_legajo primary key (ID);
alter table LEGAJO
    add constraint ck_tipo_evento check TIPO_EVENTO in ('PJ', 'CI', 'CE', 'SP', 'VC');

create sequence SEC_ASISTENCIA start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;

create sequence SEC_LEGAJO start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min,
    to_char(avg(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
select SUM((dv.cantidad*dv.precio)) as ventas_empleado from b_detalle_ventas dv inner join b_ventas v on dv.id_venta= v.id;
select id as cod_puesto_actual, id_area
from b_posicion_actual
where cedula in ('1607843', '2204219', '3008180') and fecha_fin is null;
CREATE OR REPLACE VIEW V_MAX_C AS
SELECT e.nombre||' '||e.apellido nombre, S.NOMBRE_CAT nombrecat, A.NOMBRE_AREA areas, MAX(S.ASIGNACION) asig
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
GROUP BY e.nombre||' '||e.apellido, S.NOMBRE_CAT, A.NOMBRE_AREA;
CREATE PROFILE perfil1   LIMIT

SESSIONS_PER_USER 2

IDLE_TIME 5

FAILED_LOGIN_ATTEMPTS 3;
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail.com';
select * from b_areas;
select id_venta, numero_cuota, to_char(monto_cuota, 999.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
alter table b_planilla
	add (multas number(9) default 0 NOT NULL);
select e.cedula, v.monto_total
from b_ventas v
inner join b_empleados e
    on v.cedula_vendedor = e.cedula
where e.cedula = '1998898';
CREATE OR REPLACE VIEW V_MAX_B AS
    SELECT e.nombre||' '||e.apellido NOMBRE, S.NOMBRE_CAT CATEGORIA, A.NOMBRE_AREA AREA, MAX(S.ASIGNACION) ASIGNACION
    FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
    WHERE A.ID = P.ID_AREA AND E.CEDULA = P.CEDULA
        AND S.COD_CATEGORIA = P.COD_CATEGORIA
        AND S.FECHA_FIN IS NULL
        AND P.FECHA_FIN IS NULL
    GROUP BY e.nombre||' '||e.apellido, S.NOMBRE_CAT, A.NOMBRE_AREA;
add constraint pk_dependientes PRIMARY KEY (CEDULA_DEPEN, CEDULA);
create table LEGAJO(
    ID                      NUMBER(8) NULL,
    DESCRIPCION_EVENTO      VARCHAR2(500) NOT NULL,
    TIPO_EVENTO             VARCHAR2(2) NOT NULL,
    FECHA_EVENTO            DATE NOT NULL,
    DURACION                NUMBER(3) NOT NULL,
    CEDULA                  NUMBER(11) NOT NULL
);
select cedula, f_obtener_salario(cedula) salario from b_empleados;
select * from b_planilla;
select cedula, f_obtener_salario(cedula) salario from b_empleados;
add constraint pk_dependientes PRIMARY KEY (CEDULA_DEPEN, CEDULA);
create table LEGAJO(
    ID                      NUMBER(8) NULL,
    DESCRIPCION_EVENTO      VARCHAR2(500) NOT NULL,
    TIPO_EVENTO             VARCHAR2(2) NOT NULL,
    FECHA_EVENTO            DATE NOT NULL,
    DURACION                NUMBER(3) NOT NULL,
    CEDULA                  NUMBER(11) NOT NULL
);
CREATE OR REPLACE VIEW V_MAX_B AS
    SELECT e.nombre||' '||e.apellido NOMBRE, S.NOMBRE_CAT CATEGORIA, A.NOMBRE_AREA AREA, MAX(S.ASIGNACION) ASIGNACION
    FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
    WHERE A.ID = P.ID_AREA AND E.CEDULA = P.CEDULA
        AND S.COD_CATEGORIA = P.COD_CATEGORIA
        AND S.FECHA_FIN IS NULL
        AND P.FECHA_FIN IS NULL
    GROUP BY e.nombre||' '||e.apellido, S.NOMBRE_CAT, A.NOMBRE_AREA;
select e.cedula, v.monto_total
from b_ventas v
inner join b_empleados e
    on v.cedula_vendedor = e.cedula
where e.cedula = '1998898';
alter table b_planilla
	add (multas number(9) default 0 NOT NULL);
select id_venta, numero_cuota, to_char(monto_cuota, 999.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select * from b_areas;
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail.com';
CREATE PROFILE perfil1   LIMIT

SESSIONS_PER_USER 2

IDLE_TIME 5

FAILED_LOGIN_ATTEMPTS 3;
CREATE OR REPLACE VIEW V_MAX_C AS
SELECT e.nombre||' '||e.apellido nombre, S.NOMBRE_CAT nombrecat, A.NOMBRE_AREA areas, MAX(S.ASIGNACION) asig
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
GROUP BY e.nombre||' '||e.apellido, S.NOMBRE_CAT, A.NOMBRE_AREA;
select id as cod_puesto_actual, id_area
from b_posicion_actual
where cedula in ('1607843', '2204219', '3008180') and fecha_fin is null;
select SUM((dv.cantidad*dv.precio)) as ventas_empleado from b_detalle_ventas dv inner join b_ventas v on dv.id_venta= v.id;
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min,
    to_char(avg(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
alter table ASISTENCIA
    add constraint pk_asistencia PRIMARY KEY (ID);
create table DEPENDIENTES(
    CEDULA_DEPEN        NUMBER(11) NOT NULL,
    CEDULA              NUMBER(11) NOT NULL,
    NOMBRE              VARCHAR2(40) NOT NULL,
    APELLIDO            VARCHAR2(40) NOT NULL,
    FECHA_NACIMIENTO    DATE NOT NULL,
    FECHA_ACTUALIZ      DATE NULL
);
alter table DEPENDIENTES
    add constraint fk_cedula_dependientes foreign key (CEDULA) references B_EMPLEADOS;
alter table DEPENDIENTES
    add constraint pk_dependientes PRIMARY KEY (CEDULA_DEPEN, CEDULA);
create table LEGAJO(
    ID                      NUMBER(8) NULL,
    DESCRIPCION_EVENTO      VARCHAR2(500) NOT NULL,
    TIPO_EVENTO             VARCHAR2(2) NOT NULL,
    FECHA_EVENTO            DATE NOT NULL
    DURACION                NUMBER(3) NOT NULL
    CEDULA                  NUMBER(11) NOT NULL
)
alter table LEGAJO
    add constraint fk_cedula_legajo foreign key (CEDULA) references B_EMPLEADOS;
alter table LEGAJO
    add constraint pk_legajo primary key (ID);
alter table LEGAJO
    add constraint ck_tipo_evento check TIPO_EVENTO in ('PJ', 'CI', 'CE', 'SP', 'VC');

create sequence SEC_ASISTENCIA start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;

create sequence SEC_LEGAJO start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;
WITH compras AS (SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD*D.PRECIO_COMPRA) MONTO
                FROM B_DETALLE_COMPRAS D
                JOIN B_COMPRAS C ON C.ID = D.ID_COMPRA
                WHERE C.FECHA LIKE '%11' GROUP BY D.ID_ARTICULO),
ventas AS(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO) MONTO
                FROM B_DETALLE_VENTAS D
                JOIN B_VENTAS V ON V.ID = D.ID_VENTA
                WHERE V.FECHA LIKE '%11'
                GROUP BY D.ID_ARTICULO)
SELECT A.ID, A.NOMBRE, COM.CANTIDAD COMPRA, COM.MONTO MONTO_COMPRAS, VEN.CANTIDAD VENTAS, VEN.MONTO MONTO_VENTAS
FROM B_ARTICULOS A
LEFT OUTER JOIN compras COM ON COM.ID_ARTICULO = A.ID
LEFT OUTER JOIN ventas VEN ON VEN.ID_ARTICULO = A.ID;
select id_venta, numero_cuota, to_char(monto_cuota, 999.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY');
select id_venta, numero_cuota,to_char(monto_cuota, 9.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY');
CREATE OR REPLACE VIEW V_MAX AS
SELECT e.nombre||' '||e.apellido nombre, S.NOMBRE_CAT nombrecat, S.ASIGNACION asig, A.NOMBRE_AREA areas
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
AND S.ASIGNACION = (
SELECT MAX(S.ASIGNACION) asi
FROM B_CATEGORIAS_SALARIALES S);
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."')  as salario_max, min(c.asignacion) as salario_min, avg(c.asignacion) as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
select * from b_personas
where tipo_persona='F'
    and (correo_electronico like '%@hotmail%' or correo_electronico like '%@gmail%');
ALTER SESSION set "_ORACLE_SCRIPT"=true;
 CREATE TABLE b_areas_nueva AS SELECT b.id, b.nombre_area, b.fecha_crea, b.activa, b.id_area_superior FROM b_areas b;
select v.cedula_vendedor, SUM((dv.cantidad*dv.precio)) as ventas_empleado
from b_detalle_ventas dv 
inner join b_ventas v on dv.id_venta= v.id
group by v.cedula_vendedor;
create or replace function f_obtener_salario(pcedula number)
  return number is
  v_salario number;
begin
  select c.asignacion into v_salario
  from b_posicion_actual p join b_categorias_salariales c
  on c.cod_categoria = p.cod_categoria
  where
  p.cedula = pcedula
  and p.fecha_fin is null
  and c.fecha_fin is null;
  return v_salario;
exception
  when no_data_found then
    return -1;
end;/
select SUM((dv.cantidad*dv.precio)) as ventas_empleado
from b_detalle_ventas dv 
inner join b_ventas v 
    on dv.id_venta = v.id
inner join b_empleados e
    on v.cedula_vendedor = e.cedula;
CREATE OR REPLACE VIEW V_MAX AS
    SELECT e.nombre||' '||e.apellido NOMBRE, S.NOMBRE_CAT CATEGORIA, A.NOMBRE_AREA AREA, MAX(S.ASIGNACION) ASIGNACION
    FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
    WHERE A.ID = P.ID_AREA AND E.CEDULA = P.CEDULA
        AND S.COD_CATEGORIA = P.COD_CATEGORIA
        AND S.FECHA_FIN IS NULL
        AND P.FECHA_FIN IS NULL
    GROUP BY e.nombre||' '||e.apellido, S.NOMBRE_CAT, A.NOMBRE_AREA;
select * from b_empleados;
select * from b_articulos;
TRUNCATE TABLE B_AREAS_NUEVA;
select a.id, a.nombre, a.unidad_medida, a.precio, a.porc_comision, (dv.cantidad * a.precio) as sub_total, ((dv.cantidad * a.precio) * a.porc_comision) as comision
from b_articulos a
    join b_detalle_ventas dv
        on a.id = dv.id_articulo;
SELECT /* +FIRST_ROWS */ * FROM b_personas WHERE id_localidad IN (SELECT id FROM b_localidad WHERE UPPER(nombre) = 'ASUNCION');
CREATE MATERIALIZED VIEW V_LIQUIDACION
REFRESH START WITH TRUNC(LAST_DAY(SYSDATE)) NEXT TRUNC(ADD_MONTHS(LAST_DAY(SYSDATE), 1))
AS
SELECT P.CEDULA, S.ASIGNACION SALARIO_BASICO, S.ASIGNACION*0.9 DESCUENTO_IPS,
V.BONIF_VENTAS, S.DURACION SUSPENSIONES
FROM
B_POSICION_ACTUAL P
JOIN B_CATEGORIAS_SALARIALES S ON S.COD_CATEGORIA = P.COD_CATEGORIA
LEFT OUTER JOIN
(SELECT V.CEDULA_VENDEDOR,
SUM(D.PRECIO*D.CANTIDAD*A.PORC_COMISION) BONIF_VENTAS
FROM
B_VENTAS V JOIN B_DETALLE_VENTAS D ON V.ID = D.ID_VENTA
JOIN B_ARTICULOS A ON A.ID = D.ID_ARTICULO
WHERE EXTRACT (MONTH FROM V.FECHA) = EXTRACT (MONTH FROM SYSDATE)
AND
EXTRACT (YEAR FROM V.FECHA) = EXTRACT (YEAR FROM SYSDATE)
GROUP BY V.CEDULA_VENDEDOR) V
ON V.CEDULA_VENDEDOR = P.CEDULA
LEFT OUTER JOIN (SELECT CEDULA, SUM(DURACION) DURACION
FROM LEGAJO
WHERE TIPO_EVENTO = 'SP'
AND EXTRACT (MONTH FROM FECHA_EVENTO) = EXTRACT (MONTH FROM SYSDATE)
AND EXTRACT (YEAR FROM FECHA_EVENTO) = EXTRACT (YEAR FROM SYSDATE)
GROUP BY CEDULA) S
ON S.CEDULA = P.CEDULA
WHERE
S.FECHA_FIN IS NULL
AND
P.FECHA_FIN IS NULL;
drop table ASISTENCIA;

drop table LEGAJO;

drop table DEPENDIENTES;
create table ASISTENCIA (
	ID				NUMBER(12) NULL,
	CEDULA			NUMBER(11) NOT NULL,
	HORA_ENTRADA	DATE NOT NULL,
	HORA_SALIDA		DATE NULL
);
alter table ASISTENCIA
    add constraint ck_fecha check (HORA_SALIDA IS NULL) OR (HORA_SALIDA > HORA_ENTRADA) AND TRUNC(HORA_SALIDA) > TRUNC(HORA_ENTRADA);
alter table ASISTENCIA
    add constraint fk_cedula_asistencia foreign key (CEDULA) REFERENCES B_EMPLEADOS;
CREATE OR REPLACE VIEW V_MAX_A AS
SELECT e.nombre||' '||e.apellido nombre, S.NOMBRE_CAT nombrecat, S.ASIGNACION asig, A.NOMBRE_AREA areas
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL
AND S.ASIGNACION = (
SELECT MAX(S.ASIGNACION)
FROM B_POSICION_ACTUAL P, B_AREAS A, B_EMPLEADOS E, B_CATEGORIAS_SALARIALES S
WHERE A.ID = P.ID_AREA
AND E.CEDULA = P.CEDULA
AND S.COD_CATEGORIA = P.COD_CATEGORIA
AND S.FECHA_FIN IS NULL
AND P.FECHA_FIN IS NULL);
WITH 
compras AS
(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO_COMPRA) MONTO
FROM B_DETALLE_COMPRAS D JOIN B_COMPRAS C
ON    C.ID = D.ID_COMPRA
WHERE  C.FECHA LIKE '%11'
GROUP BY  D.ID_ARTICULO),
ventas AS
(SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO) MONTO
FROM B_DETALLE_VENTAS D JOIN B_VENTAS V
ON    V.ID = D.ID_VENTA
WHERE V.FECHA LIKE '%11'
GROUP BY  D.ID_ARTICULO) 
SELECT A.ID, A.NOMBRE, COM.CANTIDAD COMPRAS , COM.MONTO MONTO_COMPRAS, 
VEN.CANTIDAD VENTAS, VEN.MONTO MONTO_VENTAS
FROM B_ARTICULOS A LEFT OUTER JOIN compras COM
ON COM.ID_ARTICULO = A.ID
LEFT OUTER JOIN ventas VEN
ON VEN.ID_ARTICULO = A.ID;
select e.cedula, SUM((dv.cantidad*dv.precio)) as ventas_empleado, v.monto_total
from b_detalle_ventas dv 
inner join b_ventas v 
    on dv.id_venta = v.id
inner join b_empleados e
    on v.cedula_vendedor = e.cedula
group by e.cedula, v.monto_total;
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F';
create user BASEDATOS2 identified by BASEDATOS2	
       DEFAULT TABLESPACE BASEDATOS2
       TEMPORARY TABLESPACE TEMP;
GRANT DBA TO BASEDATOS2 WITH ADMIN OPTION;




create or replace function f_fibonacci
    (pos in number)
    return number
is
begin
    if(pos < 2) then
        return 1;
    end if;
    return (f_fibonacci(pos - 2)+f_fibonacci(pos-1));
end;
/

declare
    resultado number :=0;
begin
    resultado := f_fibonacci(6);
    dbms_output.put_line(resultado);
end;
/

create table ASISTENCIA (
	ID				NUMBER(12) NULL,
	CEDULA			NUMBER(11) NOT NULL,
	HORA_ENTRADA	DATE NOT NULL,
	HORA_SALIDA		DATE NULL
);
alter table ASISTENCIA
    add constraint ck_fecha check ((HORA_SALIDA IS NULL) OR (HORA_SALIDA > HORA_ENTRADA) AND TRUNC(HORA_SALIDA) = TRUNC(HORA_ENTRADA));
alter table ASISTENCIA
    add constraint fk_cedula_asistencia foreign key (CEDULA) REFERENCES B_EMPLEADOS;
alter table ASISTENCIA
    add constraint pk_asistencia PRIMARY KEY (ID);
create table DEPENDIENTES(
    CEDULA_DEPEN        NUMBER(11) NOT NULL,
    CEDULA              NUMBER(11) NOT NULL,
    NOMBRE              VARCHAR2(40) NOT NULL,
    APELLIDO            VARCHAR2(40) NOT NULL,
    FECHA_NACIMIENTO    DATE NOT NULL,
    FECHA_ACTUALIZ      DATE NULL
);
alter table DEPENDIENTES
    add constraint fk_cedula_dependientes foreign key (CEDULA) references B_EMPLEADOS;
alter table DEPENDIENTES
    add constraint pk_dependientes PRIMARY KEY (CEDULA_DEPEN, CEDULA);
create table LEGAJO(
    ID                      NUMBER(8) NULL,
    DESCRIPCION_EVENTO      VARCHAR2(500) NOT NULL,
    TIPO_EVENTO             VARCHAR2(2) NOT NULL,
    FECHA_EVENTO            DATE NOT NULL,
    DURACION                NUMBER(3) NOT NULL,
    CEDULA                  NUMBER(11) NOT NULL
);
alter table LEGAJO
    add constraint fk_cedula_legajo foreign key (CEDULA) references B_EMPLEADOS;
alter table LEGAJO
    add constraint pk_legajo primary key (ID);
alter table LEGAJO
    add constraint ck_tipo_evento check (TIPO_EVENTO in ('PJ', 'CI', 'CE', 'SP', 'VC'));

create sequence SEC_ASISTENCIA start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;

create sequence SEC_LEGAJO start with 1 increment by 1 minvalue 1 maxvalue 99999999 nocycle;
SELECT A.ID, A.NOMBRE, COM.CANTIDAD COMPRAS, COM.MONTO MONTO_COMPRAS, VEN.CANTIDAD VENTAS, VEN.MONTO MONTO_VENTAS
FROM B_ARTICULOS A 
LEFT OUTER JOIN (SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO_COMPRA) MONTO
                    FROM B_DETALLE_COMPRAS D
                    JOIN B_COMPRAS C ON C.ID = D.ID_COMPRA
                    WHERE C.FECHA LIKE '%11'
                    GROUP BY D.ID_ARTICULO) COM ON COM.ID_ARTICULO = A.ID
LEFT OUTER JOIN (SELECT D.ID_ARTICULO, SUM(D.CANTIDAD) CANTIDAD, SUM(D.CANTIDAD * D.PRECIO) MONTO
                    FROM B_DETALLE_VENTAS D
                    JOIN B_VENTAS V ON V.ID = D.ID_VENTA
                    WHERE V.FECHA LIKE '%11'
                    GROUP BY D.ID_ARTICULO) VEN ON VEN.ID_ARTICULO = A.ID;
select e.cedula from b_empleados e
    join b_ventas v
    on e.cedula = v.cedula_vendedor;
alter table LEGAJO
    add constraint fk_cedula_legajo foreign key (CEDULA) references B_EMPLEADOS;
alter table LEGAJO
    add constraint pk_legajo primary key (ID);
alter table LEGAJO
    add constraint ck_tipo_evento check (TIPO_EVENTO in ('PJ', 'CI', 'CE', 'SP', 'VC'));
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%hotmail%' || '%gmail%';
CREATE OR REPLACE VIEW "V_VISTA"
AS SELECT COD_CATEGORIA
FROM B_CATEGORIAS_SALARIALES WHERE UPPER(NOMBRE_CAT) like 'GERENCIA%';
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail%' or correo_electronico like '%@gmail%';
select id_venta, numero_cuota, to_char(monto_cuota, '9G999G999', 'NLS_NUMERIC_CHARACTERS="."') as monto_cuota
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select id_venta, numero_cuota,to_char(monto_cuota, 999.999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY');
select id_venta, numero_cuota, to_char(monto_cuota, 9.999999)
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select nombre, apellido, correo_electronico
from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail.com' or correo_electronico like '%@gmail.com';
select id_venta, numero_cuota, to_char(monto_cuota, '99G999G999G9999', 'NLS_NUMERIC_CHARACTERS="."')
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select e.cedula, v.monto_total
from b_ventas v
inner join b_empleados e
    on v.cedula_vendedor = e.cedula
group by e.cedula, v.monto_total;
SELECT text  FROM user_views WHERE view_name = 'V_VISTA';
select * from b_personas;
file:/home/jvillagra/Downloads/BD2/SCRIPT CREACION ESQUEMA/SCRIPT CREACION ESQUEMA/02_CREATAB_ESP_NEW.SQL
select DISTINCT precio from b_articulos;
select to_char(max(c.asignacion), '9g999g999','NLS_NUMERIC_CHARACTERS="."')  as salario_max, min(c.asignacion) as salario_min, avg(c.asignacion) as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
select *from b_personas
where tipo_persona='F'
    and correo_electronico like '%@hotmail%' or correo_electronico like '%@gmail%';
select id_venta, numero_cuota, monto_cuota
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select id_venta, numero_cuota, to_char(monto_cuota, '99G999G999G9999', 'NLS_NUMERIC_CHARACTERS="."') as monto_cuota
from b_plan_pago
where vencimiento between TO_DATE('01-JAN-11','DD-MON-YY') and TO_DATE('30-JUN-11','DD-MON-YY')
order by id_venta, numero_cuota DESC;
select p.id_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
    group by p.id_area;
select a.nombre_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
join b_areas a
    on p.id_area = a.id
    group by a.nombre_area;
select e.nombre, e.apellido
from b_posicion_actual p
    join b_empleados e on p.cedula = e.cedula where p.fecha_fin is null;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    where p.fecha_fin is null;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null;
select e.nombre, e.apellido, c.nombre_cat, (select max(asignacion) from b_categorias_salariales) salario
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
with asignacion as
(select max(asignacion) from b_categorias_salariales where fecha_fin is null)
select e.nombre, e.apellido, c.nombre_cat, asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id;
with asignacion as
(select max(c.asignacion) from b_categorias_salariales c where fecha_fin is null)
select e.nombre, e.apellido, c.nombre_cat, asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id;
with asignacion as
(select max(c.asignacion) from b_categorias_salariales c where fecha_fin is null)
select e.nombre, e.apellido, c.nombre_cat, asignacion
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and asignacion = c.asignacion;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select min(asignacion) from b_categorias_salariales where fecha_fin is null);
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null);
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion;
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion DESC;
select l.id, l.nombre
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad;
-- salario está dado por posicion y asignacion de categoria vigente para esa posicion. Ambas tienen fecha_fin = null
-- tomando como base la lista de empleados, verificar cual es el salario max, min y promedio
-- Formatear salida para que se muestren los puntos de mil
select to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min,
    to_char(avg(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_prom
from b_categorias_salariales c
where c.fecha_fin is null;
-- basado en la consulta anterior, determine la mayor y menor asignacion en cada area
-- la consulta tendrá nombre de area, asignacion max, asignacion min
select a.nombre_area,
    to_char(max(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_max,
    to_char(min(c.asignacion), '9g999g999g999','NLS_NUMERIC_CHARACTERS="."') as salario_min
from b_categorias_salariales c
join b_posicion_actual p
    on p.cod_categoria = c.cod_categoria
join b_areas a
    on p.id_area = a.id
    group by a.nombre_area;
-- determinar el nombre y apellido, nombre de categoria, asignacion y area del empleado (o empleados) con la asignacion maxima vigente
-- probar con un subquery normal, y luego con la clausula with
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion = (select max(asignacion) from b_categorias_salariales where fecha_fin is null);
-- determinar nombre, apellido, nombre de categoria, asignacion y area de empleados que tienen una asignación inferior al promedio
-- ordenar por asignacion en forma descendente
select e.nombre, e.apellido, c.nombre_cat, c.asignacion, a.nombre_area
from b_posicion_actual p
    join b_empleados e
        on p.cedula = e.cedula
    join b_categorias_salariales c
        on p.cod_categoria = c.cod_categoria
    join b_areas a
        on p.id_area = a.id
    where p.fecha_fin is null and c.asignacion <(select avg(asignacion) from b_categorias_salariales where fecha_fin is null)
    order by c.asignacion DESC;
-- obtener cantidad de clientes que hay por localidad. Tener en cuenta en tabla b_personas solo aquellas que son clientes
-- listar id, descripcion de localidad y cantidad de clientes. Asegurarsszse de que se listen las localidades que no tienen clientes
select l.id, l.nombre, count(p.id) cant_clientes
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad
group by l.id, l.nombre
order by 1;
-- listar el volumen y monto de compras y ventas que se hicieron por cada articulo durante el año 2011
-- debe listar tambien los articulos que no tuvieron movimiento
-- mostrar datos: id_articulo, nombre_articulo, cant_compras, monto_compras, cant_ventas, monto_ventas
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
join b_localidad l
    on c.id_localidad = l.id;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
left outer join b_localidad l
    on c.id_localidad = l.id;
with clientes_localidad as(
select id_localidad, count(es_cliente) clientes from b_personas where es_cliente = 'S' group by id_localidad
)
select l.id, l.nombre, c.clientes
from clientes_localidad c
right outer join b_localidad l
    on c.id_localidad = l.id;
select l.id, l.nombre, count(p.id)
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad
group by l.id, l.nombre
order by 1;
select l.id, l.nombre, count(p.id) cant_clientes
from b_localidad l
left outer join b_personas p
    on l.id = p.id_localidad
group by l.id, l.nombre
order by 1;
select a.id, a.nombre, c.cant_compras, c.monto_compras, v.cant_ventas, v.monto_ventas
from b_articulos a
left outer join (
    select dc.id_articulo, sum(dc.cantidad) cant_compras, sum(dc.precio_compra) monto_compras
    from b_detalle_compras dc
    join b_compras c
        on dc.id_compra = c.id
    where extract(year from c.fecha) = 2011
    group by dc.id_articulo
) c
    on c.id_articulo = a.id
left outer join (
    select dv.id_articulo, sum(dv.cantidad) cant_ventas, sum(dv.precio) monto_ventas
    from b_detalle_ventas dv
    join b_ventas v
        on dv.id_venta = v.id
    where extract(year from v.fecha) = 2011
    group by dv.id_articulo
) v
    on v.id_articulo = a.id;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%jose%' and upper(j.apellido) like '%caniza%')
    connect by e.cedula = e.cedula_jefe;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%JOSE%' and upper(j.apellido) like '%CAÑIZA%')
    connect by e.cedula = e.cedula_jefe;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%JOSE%' and upper(j.apellido) like '%CANIZA%')
    connect by e.cedula = e.cedula_jefe;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%JOSE%' and upper(j.apellido) like '%CANIZA%')
    connect by e.cedula_jefe = e.cedula
order by level desc;
select to_char(e.cedula) cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%JOSE%' and upper(j.apellido) like '%CANIZA%')
    connect by e.cedula_jefe = e.cedula
order by level desc;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%JOSE%' and upper(j.apellido) like '%CANIZA%')
    connect by prior e.cedula_jefe = e.cedula
order by level desc;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select j.cedula from b_empleados j where upper(j.nombre) like '%JOSE%' and upper(j.apellido) like '%CANIZA%')
    connect by prior e.cedula_jefe = e.cedula
order by level asc;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select cedula from b_empleados where upper(nombre) like '%JOSE%' and upper(apellido) like '%CANIZA%')
    connect by prior e.cedula_jefe = e.cedula;
select e.cedula, e.nombre, e.apellido
from b_empleados e
    start with e.cedula = ( select cedula from b_empleados where upper(nombre) like '%JOSE%' and upper(apellido) like '%CANIZA%')
    connect by prior e.cedula= e.cedula_jefe;
SELECT  A.ID, A.NOMBRE, 
        C.CANT_COMPRAS, C.MONTO_COMPRAS, 
        V.CANT_VENTAS, V.MONTO_VENTAS
FROM B_ARTICULOS A
LEFT OUTER JOIN ( SELECT  DC.ID_ARTICULO, 
                          SUM(DC.CANTIDAD) CANT_COMPRAS,
                          SUM(DC.PRECIO_COMPRA) MONTO_COMPRAS
                  FROM B_DETALLE_COMPRAS DC 
                  INNER JOIN B_COMPRAS C ON C.ID = DC.ID_COMPRA
                  WHERE EXTRACT(YEAR FROM C.FECHA) = 2011
                  GROUP BY DC.ID_ARTICULO
                  ) C
    ON C.ID_ARTICULO = A.ID
LEFT OUTER JOIN ( SELECT  DV.ID_ARTICULO, 
                          SUM(DV.CANTIDAD) CANT_VENTAS,
                          SUM(DV.PRECIO) MONTO_VENTAS
                  FROM B_DETALLE_VENTAS DV 
                  INNER JOIN B_VENTAS V ON V.ID = DV.ID_VENTA
                  WHERE EXTRACT(YEAR FROM V.FECHA) = 2011
                  GROUP BY DV.ID_ARTICULO
                  ) V
    ON V.ID_ARTICULO = A.ID;
    
-- listar personas que tengan misma localidad que SERVIMEX
select p.ruc, p.cedula, p.nombre, p.apellido, l.nombre
from b_personas p
join b_localidad l
    on p.id_localidad = l.id and UPPER(p.nombre) = 'SERVIMEX';
select p.ruc, p.cedula, p.nombre, p.apellido, l.nombre
from b_personas p
join b_localidad l
    on p.id_localidad = l.id;
with personas_localidad as(
select p.ruc ruc, p.cedula cedula, p.nombre nombre, p.apellido apellido, l.nombre nombre_localidad, l.id id_localidad
from b_personas p
join b_localidad l
    on p.id_localidad = l.id)
select * from personas_localidad
where id_localidad = (select id_localidad from personas_localidad where UPPER(nombre) = 'SERVIMEX');
-- listar personas con asignacion menor a salario minimo
select p.cedula,p.apellido || ', ' || p.nombre, c.cod_categoria categoria, c.nombre_cat nombre_categoria, c.asignacion
from b_empleados p
inner join b_posicion_actual pa
    on p.cedula = pa.cedula
inner join b_categorias_salariales c
    on pa.cod_categoria = c.cod_categoria
where c.asignacion < 1964507;
-- verificar cuentas imputables que no han tenido movimiento en el diario de asientos
SELECT C.CODIGO_CTA, C.NOMBRE_CTA
FROM B_CUENTAS C
WHERE NOT EXISTS (SELECT CODIGO_CTA
                  FROM B_DIARIO_DETALLE DD
                  WHERE DD.CODIGO_CTA = C.CODIGO_CTA )
      AND C.IMPUTABLE = 'S';
