BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "citas_vacunacion" (
	"id"	INTEGER,
	"fecha_cita"	DATE,
	"nombre_clinica"	VARCHAR(100),
	"perfil_pacientes_id"	INTEGER NOT NULL,
	"profesional_salud_id"	INTEGER NOT NULL,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"hora"	TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("perfil_pacientes_id") REFERENCES "perfil_pacientes"("id"),
	FOREIGN KEY("profesional_salud_id") REFERENCES "profesional_salud"("id")
);
CREATE TABLE IF NOT EXISTS datos_medicos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    peso FLOAT,
    talla FLOAT,
    registros_medicos_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (registros_medicos_id) REFERENCES registro_medicos (id)
);
CREATE TABLE IF NOT EXISTS esquema_vacunacion (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fecha_aplicacion DATE,
    vacunas_id INTEGER NOT NULL,
    perfil_pacientes_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vacunas_id) REFERENCES vacunas (id),
    FOREIGN KEY (perfil_pacientes_id) REFERENCES perfil_pacientes (id)
);
CREATE TABLE IF NOT EXISTS padres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(40),
    apellidos VARCHAR(40),
    dni VARCHAR(40) UNIQUE NOT NULL,
    genero VARCHAR(20),
    fecha_nacimiento DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS perfil_pacientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    fecha_nacimiento DATE,
    genero VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);
CREATE TABLE IF NOT EXISTS profesional_salud (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(30),
    apellidos VARCHAR(30),
    especialidad VARCHAR(50),  -- Especialidad del profesional de salud
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS registro_medicos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fecha DATE,
    perfil_pacientes_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (perfil_pacientes_id) REFERENCES perfil_pacientes (id)
);
CREATE TABLE IF NOT EXISTS "usuarios" (
	"id"	INTEGER,
	"nombre"	VARCHAR(40),
	"email"	VARCHAR(255) NOT NULL UNIQUE,
	"contrasena"	VARCHAR(255) NOT NULL,
	"dni"	VARCHAR(40) UNIQUE,
	"genero"	VARCHAR(20),
	"fecha_nacimiento"	DATE,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"padres_id"	INTEGER,
	"profesional_salud_id"	INTEGER,
	"apellido"	VARCHAR(40),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("padres_id") REFERENCES "padres"("id"),
	FOREIGN KEY("profesional_salud_id") REFERENCES "profesional_salud"("id")
);
CREATE TABLE IF NOT EXISTS vacunas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    status INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "citas_vacunacion" ("id","fecha_cita","nombre_clinica","perfil_pacientes_id","profesional_salud_id","created_at","updated_at","hora") VALUES (1,'2023-02-10','Clínica Pediátrica',1,1,'2024-11-10 05:57:50','2024-11-10 05:57:50','2023-02-10 20:30:00'),
 (2,'2023-06-15','Clínica Vacunológica',2,2,'2024-11-10 05:57:50','2024-11-10 05:57:50','2023-06-15 11:30:00'),
 (3,'2024-12-01','Clínica Central',1,1,'2024-11-28 21:04:33','2024-11-28 21:04:33','2024-12-01 09:00:00'),
 (4,'2024-12-15','Clínica Familiar',1,2,'2024-11-28 21:04:33','2024-11-28 21:04:33','2024-12-15 14:30:00');
INSERT INTO "datos_medicos" ("id","peso","talla","registros_medicos_id","created_at","updated_at") VALUES (1,30.5,1.2,1,'2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,25.0,1.1,2,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "esquema_vacunacion" ("id","fecha_aplicacion","vacunas_id","perfil_pacientes_id","created_at","updated_at") VALUES (1,'2023-02-10',1,1,'2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,'2023-06-15',2,2,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "padres" ("id","nombre","apellidos","dni","genero","fecha_nacimiento","created_at","updated_at") VALUES (1,'Juan','Pérez','12345678','Masculino','1980-05-15','2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,'María','Gómez','87654321','Femenino','1985-11-25','2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "perfil_pacientes" ("id","usuario_id","fecha_nacimiento","genero","activo","created_at","updated_at") VALUES (1,1,'2010-07-20','Masculino',1,'2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,2,'2012-08-15','Femenino',1,'2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (3,8,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (4,9,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (5,10,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (6,11,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (7,14,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (8,15,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (9,16,NULL,NULL,1,'2024-11-28 22:02:12','2024-11-28 22:02:12'),
 (10,17,NULL,NULL,1,'2024-11-28 22:27:12','2024-11-28 22:27:12');
INSERT INTO "profesional_salud" ("id","nombre","apellidos","especialidad","created_at","updated_at") VALUES (1,'Dr. Carlos','Martínez','Pediatría','2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,'Dra. Ana','López','Vacunología','2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "registro_medicos" ("id","fecha","perfil_pacientes_id","created_at","updated_at") VALUES (1,'2023-01-01',1,'2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,'2023-05-15',2,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "usuarios" ("id","nombre","email","contrasena","dni","genero","fecha_nacimiento","created_at","updated_at","padres_id","profesional_salud_id","apellido") VALUES (1,'Adolfo','esteban@mail.com','123456','11111111','Masculino','2010-07-20','2024-11-10 05:57:50','2024-11-10 05:57:50',1,1,'Gonzales'),
 (2,'Sofía','sofia@mail.com','456','22222222','Femenino','2012-08-15','2024-11-10 05:57:50','2024-11-10 05:57:50',2,2,'Ramirez'),
 (8,'abraham','abraham@mail.com','123',NULL,NULL,NULL,'2024-11-10 21:06:08.000000','2024-11-10 21:06:08.000000',NULL,NULL,NULL),
 (9,'bobi','bobi@mail.com','123',NULL,NULL,NULL,'2024-11-10 21:44:23','2024-11-10 21:44:23',NULL,NULL,NULL),
 (10,'daniel','daniel@mail.com','123',NULL,NULL,NULL,'2024-11-12 03:35:01.000000','2024-11-12 03:35:01.000000',NULL,NULL,NULL),
 (11,'jose','jose@mail.com','123',NULL,NULL,NULL,'2024-11-12 11:47:20.000000','2024-11-12 11:47:20.000000',NULL,NULL,NULL),
 (14,'ramiro','ramiro@mail.com','123',NULL,NULL,NULL,'2024-11-28 21:27:15.000000','2024-11-28 21:27:15.000000',NULL,NULL,NULL),
 (15,'marta','marta@mail.com','123',NULL,NULL,NULL,'2024-11-28 21:32:15.000000','2024-11-28 21:32:15.000000',NULL,NULL,NULL),
 (16,'miriam','miriam@mail.com','123456',NULL,NULL,NULL,'2024-11-28 21:34:15.000000','2024-11-28 21:34:15.000000',NULL,NULL,NULL),
 (17,'pipo','pipo@mail.com','123456',NULL,NULL,NULL,'2024-11-28 22:26:52.000000','2024-11-28 22:26:52.000000',NULL,NULL,NULL);
INSERT INTO "vacunas" ("id","nombre","descripcion","status","created_at","updated_at") VALUES (1,'Vacuna Hepatitis B','Vacuna contra la hepatitis B',1,'2024-11-10 05:57:50','2024-11-10 05:57:50'),
 (2,'Vacuna MMR','Vacuna contra sarampión, paperas y rubéola',1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
COMMIT;
