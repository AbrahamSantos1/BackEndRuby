require 'sinatra'
require 'sequel'
require 'sqlite3'

set :protection, except: :frame_options
set :bind, '0.0.0.0'
set :port, 4567 

# db
require_relative './configs/database'
require_relative './configs/models'

Dir[File.join(__dir__, 'routes', '*.rb')].each { |file| require_relative file }

before do
  headers 'Access-Control-Allow-Origin' => '*', # Permitir acceso desde cualquier origen
          'Access-Control-Allow-Methods' => ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], # Permitir los métodos HTTP especificados
          'Access-Control-Allow-Headers' => 'Content-Type' # Permitir el encabezado Content-Type
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  200
end

# Rutas principales
get '/' do
  '¡Hola, profe!'
end
