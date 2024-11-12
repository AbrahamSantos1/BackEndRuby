require 'sinatra'
require 'sequel'
require 'sqlite3'

set :protection, except: :frame_options
set :bind, '0.0.0.0'
set :port, 4567 

# Cargar configuración de base de datos
require_relative './configs/database'

# Cargar modelos y rutas
require_relative './configs/models'

Dir[File.join(__dir__, 'routes', '*.rb')].each { |file| require_relative file }

# Rutas principales
get '/' do
  '¡Hola, profe!'
end
