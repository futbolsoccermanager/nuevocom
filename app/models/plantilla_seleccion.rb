class PlantillaSeleccion < ActiveRecord::Base
  attr_accessible :seleccion_id, :jugador_id

  belongs_to :seleccion
  belongs_to :jugador
end
