require 'sinatra'
require 'sequel'
require 'sqlite3'

# Cargar configuración de base de datos
require './configs/database'

# Cargar modelos y rutas
require './configs/models'
require './routes/usuario'

# Rutas principales
get '/' do
  '¡Hola, profe!'
end
