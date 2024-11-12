# app.rb
require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'sqlite3'

DB = Sequel.sqlite('db/basededatos.db')
DB.run "PRAGMA foreign_keys = ON"  # Habilitar las claves foráneas
Sequel::Model.plugin :json_serializer


# Configuración del servidor
 # Esto permite acceder desde cualquier IP de la red local
set :logging, true      # Para habilitar el registro de logs
set :environment, :development  # O :production dependiendo de tu entorno
