#Endpoint que recoge los datos medicos para crear historial de IMC

post '/datos_medicos/:usuario_id/:perfil_paciente_id/:registros_medicos_id' do
    # Obtener parámetros de la URL
    usuario_id = params[:usuario_id]
    perfil_paciente_id = params[:perfil_paciente_id]
    registros_medicos_id = params[:registros_medicos_id]
  
    # Validar si el usuario, perfil del paciente y registro médico existen
    datos = DB[:datos_medicos]
            .join(:registro_medicos, id: :registros_medicos_id)
            .join(:perfil_pacientes, id: :perfil_pacientes_id)
            .join(:usuarios, id: :usuario_id)
            .where(Sequel[:usuarios][:id] => usuario_id)
            .where(Sequel[:perfil_pacientes][:id] => perfil_paciente_id)
            .where(Sequel[:datos_medicos][:registros_medicos_id] => registros_medicos_id)
            .select(
              Sequel[:datos_medicos][:id].as(:id_datos_medicos),
              Sequel[:usuarios][:id].as(:usuario_id),
              Sequel[:perfil_pacientes][:id].as(:perfil_paciente_id),
              Sequel[:registro_medicos][:id].as(:registros_medicos_id),
              Sequel[:datos_medicos][:peso],
              Sequel[:datos_medicos][:talla],
              Sequel[:datos_medicos][:created_at]
            )
            .first
  
    # Validar si se encontraron datos
    if datos.nil?
      halt 404, { error: "No se encontraron datos médicos con los parámetros especificados." }.to_json
    end
  
    # Responder con los datos en formato JSON
    datos.to_json
  end

  
# Endpoint encargado en el calendario de vacunas

get '/calendario_vacunas/:perfil_pacientes_id' do
  perfil_paciente_id = params[:perfil_pacientes_id]

  vacunas = DB.fetch(<<-SQL, perfil_paciente_id).all
    SELECT 
      v.id AS vacuna_id,
      v.nombre AS nombre_vacuna,
      v.descripcion AS descripcion_vacuna,
      v.status AS estado_vacuna,
      e.fecha_aplicacion AS fecha_aplicacion
    FROM vacunas v
    INNER JOIN esquema_vacunacion e
      ON v.id = e.vacunas_id
    WHERE e.perfil_pacientes_id = ?;
  SQL

  if vacunas.any?
    content_type :json
    vacunas.to_json
  else
    status 404
    { error: 'No hay vacunas asociadas a este perfil de paciente.' }.to_json
  end
end

  

  