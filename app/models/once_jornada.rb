class OnceJornada
  include MongoMapper::Document


  key :seleccion_id, Integer

  key :jornada, Integer

  key :jugadores, Array

  key :puntuacion, Integer

  scope :jugadores_por_equipo, lambda { |jornada, seleccion_id|
    where(:jornada => jornada, :seleccion_id =>  seleccion_id)
  }


end