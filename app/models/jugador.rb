class Jugador < ActiveRecord::Base
  attr_accessible :apellidos, :apodo, :equipo_id, :foto, :nombre, :precio

  belongs_to :equipo
end
