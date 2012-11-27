# == Schema Information
#
# Table name: plantilla_selecciones
#
#  id           :integer          not null, primary key
#  seleccion_id :integer
#  jugador_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  titular      :boolean
#

class PlantillaSeleccion < ActiveRecord::Base
  attr_accessible :seleccion_id, :jugador_id

  belongs_to :seleccion
  belongs_to :jugador


end
