-- Insertar padres
INSERT INTO padres (nombre, apellidos, dni, genero, fecha_nacimiento)
VALUES
    ('Juan', 'Pérez', '12345678', 'Masculino', '1980-05-15'),
    ('María', 'Gómez', '87654321', 'Femenino', '1985-11-25');

-- Insertar profesionales de salud
INSERT INTO profesional_salud (nombre, apellidos, especialidad)
VALUES
    ('Dr. Carlos', 'Martínez', 'Pediatría'),
    ('Dra. Ana', 'López', 'Vacunología');

-- Insertar usuarios
INSERT INTO usuarios (nombre, email, contrasena, dni, genero, fecha_nacimiento, padres_id, profesional_salud_id)
VALUES
    ('Esteban', 'esteban@mail.com', 'password123', '11111111', 'Masculino', '2010-07-20', 1, 1),
    ('Sofía', 'sofia@mail.com', 'password456', '22222222', 'Femenino', '2012-08-15', 2, 2);

-- Insertar perfil de pacientes
INSERT INTO perfil_pacientes (usuario_id, fecha_nacimiento, genero, activo)
VALUES
    (1, '2010-07-20', 'Masculino', TRUE),
    (2, '2012-08-15', 'Femenino', TRUE);

-- Insertar registros médicos
INSERT INTO registro_medicos (fecha, perfil_pacientes_id)
VALUES
    ('2023-01-01', 1),
    ('2023-05-15', 2);

-- Insertar datos médicos
INSERT INTO datos_medicos (peso, talla, registros_medicos_id)
VALUES
    (30.5, 1.2, 1),  -- Registro para Esteban
    (25.0, 1.1, 2);  -- Registro para Sofía

-- Insertar vacunas
INSERT INTO vacunas (nombre, descripcion, status)
VALUES
    ('Vacuna Hepatitis B', 'Vacuna contra la hepatitis B', 1),
    ('Vacuna MMR', 'Vacuna contra sarampión, paperas y rubéola', 1);

-- Insertar esquema de vacunación
INSERT INTO esquema_vacunacion (fecha_aplicacion, vacunas_id, perfil_pacientes_id)
VALUES
    ('2023-02-10', 1, 1),  -- Vacuna Hepatitis B para Esteban
    ('2023-06-15', 2, 2);  -- Vacuna MMR para Sofía

-- Insertar citas de vacunación
INSERT INTO citas_vacunacion (fecha_cita, nombre_clinica, perfil_pacientes_id, profesional_salud_id)
VALUES
    ('2023-02-10', 'Clínica Pediátrica', 1, 1),  -- Cita de Esteban con Dr. Carlos
    ('2023-06-15', 'Clínica Vacunológica', 2, 2);  -- Cita de Sofía con Dra. Ana
