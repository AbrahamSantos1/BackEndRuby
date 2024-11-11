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
CREATE TABLE IF NOT EXISTS "datos_medicos" (
	"id"	INTEGER,
	"peso"	FLOAT,
	"talla"	FLOAT,
	"registros_medicos_id"	INTEGER NOT NULL,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("registros_medicos_id") REFERENCES "registro_medicos"("id")
);
CREATE TABLE IF NOT EXISTS "esquema_vacunacion" (
	"id"	INTEGER,
	"fecha_aplicacion"	DATE,
	"vacunas_id"	INTEGER NOT NULL,
	"perfil_pacientes_id"	INTEGER NOT NULL,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("perfil_pacientes_id") REFERENCES "perfil_pacientes"("id"),
	FOREIGN KEY("vacunas_id") REFERENCES "vacunas"("id")
);
CREATE TABLE IF NOT EXISTS "padres" (
	"id"	INTEGER,
	"nombre"	VARCHAR(40),
	"apellidos"	VARCHAR(40),
	"dni"	VARCHAR(40) NOT NULL UNIQUE,
	"genero"	VARCHAR(20),
	"fecha_nacimiento"	DATE,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "perfil_pacientes" (
	"id"	INTEGER,
	"usuario_id"	INTEGER NOT NULL,
	"fecha_nacimiento"	DATE,
	"genero"	VARCHAR(20),
	"activo"	BOOLEAN DEFAULT TRUE,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("usuario_id") REFERENCES "usuarios"("id")
);
CREATE TABLE IF NOT EXISTS "profesional_salud" (
	"id"	INTEGER,
	"nombre"	VARCHAR(30),
	"apellidos"	VARCHAR(30),
	"especialidad"	VARCHAR(50),
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "registro_medicos" (
	"id"	INTEGER,
	"fecha"	DATE,
	"perfil_pacientes_id"	INTEGER NOT NULL,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("perfil_pacientes_id") REFERENCES "perfil_pacientes"("id")
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
CREATE TABLE IF NOT EXISTS "vacunas" (
	"id"	INTEGER,
	"nombre"	VARCHAR(100),
	"descripcion"	TEXT,
	"status"	INTEGER,
	"created_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	"updated_at"	TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "citas_vacunacion" VALUES (1,'2023-02-10','Clínica Pediátrica',1,1,'2024-11-10 05:57:50','2024-11-10 05:57:50','2023-02-10 20:30:00');
INSERT INTO "citas_vacunacion" VALUES (2,'2023-06-15','Clínica Vacunológica',2,2,'2024-11-10 05:57:50','2024-11-10 05:57:50','2023-06-15 11:30:00');
INSERT INTO "datos_medicos" VALUES (1,30.5,1.2,1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "datos_medicos" VALUES (2,25.0,1.1,2,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "esquema_vacunacion" VALUES (1,'2023-02-10',1,1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "esquema_vacunacion" VALUES (2,'2023-06-15',2,2,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "padres" VALUES (1,'Juan','Pérez','12345678','Masculino','1980-05-15','2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "padres" VALUES (2,'María','Gómez','87654321','Femenino','1985-11-25','2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "perfil_pacientes" VALUES (1,1,'2010-07-20','Masculino',1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "perfil_pacientes" VALUES (2,2,'2012-08-15','Femenino',1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "profesional_salud" VALUES (1,'Dr. Carlos','Martínez','Pediatría','2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "profesional_salud" VALUES (2,'Dra. Ana','López','Vacunología','2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "registro_medicos" VALUES (1,'2023-01-01',1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "registro_medicos" VALUES (2,'2023-05-15',2,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "usuarios" VALUES (1,'Esteban','esteban@mail.com','123','11111111','Masculino','2010-07-20','2024-11-10 05:57:50','2024-11-10 05:57:50',1,1,'Gonzales');
INSERT INTO "usuarios" VALUES (2,'Sofía','sofia@mail.com','456','22222222','Femenino','2012-08-15','2024-11-10 05:57:50','2024-11-10 05:57:50',2,2,'Ramirez');
INSERT INTO "usuarios" VALUES (7,'Steep','steep@mail.com','789',NULL,NULL,NULL,'2024-11-10 06:44:24.000000','2024-11-10 06:44:24.000000',NULL,NULL,NULL);
INSERT INTO "usuarios" VALUES (8,'abraham','abraham@mail.com','123',NULL,NULL,NULL,'2024-11-10 21:06:08.000000','2024-11-10 21:06:08.000000',NULL,NULL,NULL);
INSERT INTO "vacunas" VALUES (1,'Vacuna Hepatitis B','Vacuna contra la hepatitis B',1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
INSERT INTO "vacunas" VALUES (2,'Vacuna MMR','Vacuna contra sarampión, paperas y rubéola',1,'2024-11-10 05:57:50','2024-11-10 05:57:50');
COMMIT;
