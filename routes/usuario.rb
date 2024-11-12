
# Endpoint de login (usuario)
post '/usuario/login' do
  request_payload = JSON.parse(request.body.read)
  email = request_payload['email']
  password = request_payload['password']
  
  if email.empty? || password.empty?
    status 400
    return { message: 'El correo electrónico y la contraseña son requeridos' }.to_json
  end

  usuario = Usuario.first(email: email)
  
  if usuario && usuario.contrasena == password
    status 200
    { message: 'Login exitoso' }.to_json
  else
    status 401
    { message: 'Correo electrónico o contraseña incorrectos' }.to_json
  end
end

# Endpoint de Perfil (usuario)
get '/usuario/perfil/:id' do
  usuario = Usuario[params[:id]]
  
  if usuario
    perfil = usuario.perfil_pacientes.first
    if perfil
      citas = perfil.citas_vacunacion.map do |cita|
        {
          fecha_cita: cita.fecha_cita,
          nombre_clinica: cita.nombre_clinica,
          especialidad_doctor: cita.profesional_salud.especialidad,
          hora_cita: cita.hora
        }
      end
      perfil_data = {
        nombre: usuario.nombre,
        apellidos: usuario.apellido,
        citas_proximas: citas
      }
      status 200
      perfil_data.to_json
    else
      status 404
      { message: 'Perfil no encontrado' }.to_json
    end
  else
    status 404
    { message: 'Usuario no encontrado' }.to_json
  end
end


post '/usuario/crear_cuenta' do
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
    usuario = DB[:usuarios].where(email: correo).first
    puts "Correo recibido: #{correo}"

    if usuario
      puts "Nueva contraseña generada: #{new_password}"
      updated_rows = DB[:usuarios].where(id: usuario[:id]).update(contrasena: new_password)
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
  correo = params[:email].strip
  nombre = params[:nombre].strip
  new_password = params[:contrasena].strip
  # db access
  begin
    usuario = DB[:usuarios].where(email: correo).first
    puts "Correo recibido: #{correo}"

    if usuario
      puts "Nueva contraseña generada: #{new_password}"
      updated_rows = DB[:usuarios].where(id: usuario[:id]).update(contrasena: new_password)
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

