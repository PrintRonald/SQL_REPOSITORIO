
/* Parte 1: Crear entorno de trabajo
   Crear una base de datos */
CREATE SCHEMA tareagrupal5 DEFAULT CHARACTER SET utf8 ;

/* Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.*/
CREATE USER 'tareagrupal5@localhost' IDENTIFIED BY '1234';
GRANT ALL ON tareagrupal5.* TO 'tareagrupal5@localhost';



/*
Parte 2: Crear dos tablas.
- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, zona horaria 
  (por defecto UTC-3), género y teléfono de contacto).*/
  CREATE TABLE usuarios (
  id_usuario TINYINT NOT NULL auto_increment,
  nombre VARCHAR(45) NULL,
  apellido VARCHAR(45) NULL,
  contrasena VARCHAR(15) NULL,
  zona_horaria VARCHAR(15) NULL default 'UTC-3',
  genero VARCHAR(1) NULL,
  telefono VARCHAR(12) NOT NULL,
  PRIMARY KEY (id_usuario, telefono)
  );
  select * from usuarios;
  update usuarios set telefono = '9999999' where id_usuario = 1;
 /*La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a 
  la plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual)).*/
   CREATE TABLE informacion (
  id_ingreso TINYINT NOT NULL auto_increment,
  id_usuario TINYINT NOT NULL,
  fecha_hora_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (id_ingreso),
  FOREIGN KEY (id_usuario)REFERENCES usuarios (id_usuario)
	ON DELETE CASCADE
	ON UPDATE CASCADE
  );
  select * from informacion;
    /*Parte 3: Modificación de la tabla
Modifique el UTC por defecto.Desde UTC-3 a UTC-2.*/
ALTER TABLE usuarios MODIFY COLUMN zona_horaria VARCHAR(50) 
DEFAULT 'UTC-2';

  /*Parte 4: Creación de registros.
- Para cada tabla crea 8 registros.*/

  insert into usuarios (nombre, apellido, contrasena, genero, telefono)
values 
('Alexandru ','Perdomo','xxx xxx','M','23498754'),
('Marc ','Sanmartin','xxx xxx','M','95439431'),
('Enric ','Matos','xxx xxx','M','94352911'),
('Nadia ','Barea','xxx xxx','F','93234523'),
('Elvira ','Garces','xxx xxx','F','94327687'),
('Francesc Xavier ','Montaño','xxx xxx','F','912346543'),
('Carmen ','Cañas','xxx xxx','F','93456231'),
('Jan ','Villar','xxx xxx','M','934532344');

insert into informacion (id_usuario, fecha_hora_ingreso)
value 
(1,CURRENT_TIMESTAMP()),
(4,CURRENT_TIMESTAMP()),
(2,CURRENT_TIMESTAMP()),
(5,CURRENT_TIMESTAMP()),
(8,CURRENT_TIMESTAMP()),
(3,CURRENT_TIMESTAMP()),
(2,CURRENT_TIMESTAMP()),
(1,CURRENT_TIMESTAMP());

  
/*Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?*/
/*

VARCHAR: se ocupo en las columnas NOMBRE, APELLIDO, CONTRASEÑA, ZONA_HORARIA, GENERO,TELEFONO
donde asignamos una longitud correspondiente a los datos que fueron solicitados. El VARCHAR Fue asignado porque son datos de tipo string.

TINYINT: fue utilizado para los atributos id_usuario, id_ingreso, ya que nuestra base de datos está
pensada para el ingreso de una cantidad limitada de registros (8 registros), ya que ocupa menos memoria que
el formato INT.

DATETIME: se utilizo para el campo fecha_hora_ingreso porque se nos solicitaba informacion sobre hora y fecha.
*/

/*Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).*/
	CREATE TABLE contactos (
  id_contacto TINYINT NOT NULL auto_increment,
  id_usuario TINYINT NOT NULL,
  telefono VARCHAR(12) NULL,
  correo VARCHAR(30) NULL,
  PRIMARY KEY (id_contacto),
  FOREIGN KEY (telefono) REFERENCES usuarios (telefono)
	ON DELETE CASCADE
	ON UPDATE CASCADE
  );
  
  insert into contactos (id_usuario, telefono, correo)
values
(1, 23498754,'crosapuxidoi-3622@yopmail.com'),
(2, 95439431,'jauttaddubr6985@yopmail.com'),
(3, 94352911,'deveuxellutti0@yopmail.com'),
(4, 93234523,'gresahunnaqua-3@yopmail.com'),
(5, 94327687,'xiddaffibrelau430@yopmail.com'),
(6, 912346543,'sabrupraxemeu62@yopmail.com'),
(7, 93456231,'gronneissoqueug8@yopmail.com'),
(8, 934532344,'hicruppouqua61@yopmail.com');
  
 select * from contactos; 
 
 /*Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.
El ejercicio debe ser subido a github y al Nodo Virtual.
En este caso se modifica la columna "telefono" y se modifica el tipo de almacenamiento del dato con el formato "UNIQUE" para
que se pueda crear la llave foranea y la relación entre ambas tablas*/

CREATE TABLE usuarios (
  id_usuario TINYINT NOT NULL auto_increment,
  nombre VARCHAR(45) NULL,
  apellido VARCHAR(45) NULL,
  contrasena VARCHAR(15) NULL,
  zona_horaria VARCHAR(15) NULL default 'UTC-3',
  genero VARCHAR(1) NULL,
  telefono VARCHAR(12) NOT NULL UNIQUE,
  PRIMARY KEY (id_usuario, telefono)
  );