class OnceJornada
  include MongoMapper::Document


  key :seleccion_id, Integer

  key :jornada

  key :jugadores, Array

  key :puntuacion, Integer



end