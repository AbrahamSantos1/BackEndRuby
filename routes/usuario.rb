
# Endpoint de login (usuario)
post '/login' do
  request_payload = JSON.parse(request.body.read)
  email = request_payload['email']
  password = request_payload['password']

  if email.empty? || password.empty?
    status 400
    return { message: 'El correo electrónico y la contraseña son requeridos' }.to_json
  end

  usuario = Usuario.first(email: email)

  if usuario && usuario.contrasena == password
    perfil = usuario.perfil_pacientes.first
    proxima_cita = perfil&.citas_vacunacion&.first

    status 200
    {
      message: 'Login exitoso',
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        apellido: usuario.apellido,
        email: usuario.email,
        cita_medica: proxima_cita ? {
          especialidad_doctor: proxima_cita.profesional_salud&.especialidad,
          dia: proxima_cita.fecha_cita,
          hora: proxima_cita.hora
        } : nil
      }
    }.to_json
  else
    status 401
    { message: 'Correo electrónico o contraseña incorrectos' }.to_json
  end
end



# Endpoint de Perfil (usuario)
get '/perfil/:id' do
  usuario = Usuario[params[:id]]

  if usuario
    perfil = usuario.perfil_pacientes.first
    perfil ||= PerfilPaciente.create(usuario_id: usuario.id, fecha_nacimiento: nil, genero: nil, activo: true)

    citas = perfil.citas_vacunacion.map do |cita|
      {
        fecha_cita: cita.fecha_cita || nil,
        nombre_clinica: cita.nombre_clinica || '',
        especialidad_doctor: cita.profesional_salud&.especialidad || '',
        hora_cita: cita.hora || nil
      }
    end

    perfil_data = {
      nombre: usuario.nombre || 'Usuario',
      apellidos: usuario.apellido || '',
      citas_proximas: citas
    }
    status 200
    perfil_data.to_json
  else
    status 404
    { message: 'Usuario no encontrado' }.to_json
  end
end



post '/crear_cuenta' do
  request_payload = JSON.parse(request.body.read)
  
  nombre = request_payload['nombre']
  email = request_payload['email']
  password = request_payload['password']
  password_confirmation = request_payload['password_confirmation']
  
  if password != password_confirmation
    status 400
    return { message: 'Las contraseñas no coinciden' }.to_json
  end

  usuario_existente = Usuario.first(email: email)
  
  if usuario_existente
    status 409
    { message: 'El correo electrónico ya está registrado' }.to_json
  else
    usuario = Usuario.create(nombre: nombre, email: email, contrasena: password)
    
    if usuario.save
      status 201
      { message: 'Cuenta creada exitosamente', user_id: usuario.id }.to_json
    else
      status 500
      { message: 'Error al crear la cuenta. Intente nuevamente más tarde.' }.to_json
    end
  end
end

post '/usuario/cambiar-contrasena' do
  # params
  status = 500
  resp = ''
  correo = params[:email].strip
  new_password = params[:contrasena].strip
  # db access
  begin
    usuario = Usuario.first(email: correo)
    puts "Correo recibido: #{correo}"

    if usuario
      puts "Nueva Contraseña: #{new_password}"
      usuario.update(contrasena: new_password)
      status = 200
      resp = 'Contraseña actualizada'
    else
      status = 404
      resp = 'Correo no registrado'
    end
  rescue Sequel::DatabaseError => e
      resp = e.message
  rescue StandardError => e
      resp = e.message
  end
    # response
  status status
  resp
end

post '/usuario/modificar-perfil' do
  # params
  status = 500
  resp = ''
  usuario_id = params[:id].strip
  correo = params[:email].strip
  new_name = params[:nombre].strip
  new_password = params[:contrasena].strip
  # db access
  begin
    usuario = Usuario.first(id: usuario_id)
    if usuario
      usuario.update(email: correo, nombre: new_name, contrasena: new_password)
      status = 200
      resp = 'Datos actualizados'
    else
      status = 404
      resp = 'Error al actualizar los datos'
    end
  rescue Sequel::DatabaseError => e
      resp = e.message
  rescue StandardError => e
      resp = e.message
  end
    # response
  status status
  resp
end

