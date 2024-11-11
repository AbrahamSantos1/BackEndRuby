# Requiere la base de datos
require_relative 'database'

# Modelo de Usuario
class Usuario < Sequel::Model(:usuarios)
  one_to_many :perfil_pacientes, key: :usuario_id
  many_to_one :padre, key: :padres_id
  many_to_one :profesional_salud, key: :profesional_salud_id
end

# Modelo de PerfilPaciente
class PerfilPaciente < Sequel::Model(:perfil_pacientes)
  many_to_one :usuario, key: :usuario_id
  one_to_many :citas_vacunacion, key: :perfil_pacientes_id
  one_to_many :registro_medicos, key: :perfil_pacientes_id
  one_to_many :esquema_vacunacion, key: :perfil_pacientes_id
end

# Modelo de CitaVacunacion
class CitasVacunacion < Sequel::Model(:citas_vacunacion)
  many_to_one :perfil_paciente, key: :perfil_pacientes_id
  many_to_one :profesional_salud, key: :profesional_salud_id
  many_to_one :vacuna, key: :vacunas_id
end

# Modelo de Vacuna
class Vacuna < Sequel::Model(:vacunas)
  one_to_many :esquema_vacunacion, key: :vacunas_id
  one_to_many :citas_vacunacion, key: :vacunas_id
end

# Modelo de EsquemaVacunacion
class EsquemaVacunacion < Sequel::Model(:esquema_vacunacion)
  many_to_one :vacuna, key: :vacunas_id
  many_to_one :perfil_paciente, key: :perfil_pacientes_id
end

# Modelo de RegistroMedico
class RegistroMedico < Sequel::Model(:registro_medicos)
  many_to_one :perfil_paciente, key: :perfil_pacientes_id
  one_to_many :datos_medicos, key: :registros_medicos_id
end

# Modelo de DatosMedicos
class DatosMedicos < Sequel::Model(:datos_medicos)
  many_to_one :registro_medico, key: :registros_medicos_id
end

# Modelo de Padres
class Padre < Sequel::Model(:padres)
  one_to_many :usuarios, key: :padres_id
end

# Modelo de ProfesionalSalud
class ProfesionalSalud < Sequel::Model(:profesional_salud)
  one_to_many :usuarios, key: :profesional_salud_id
end
