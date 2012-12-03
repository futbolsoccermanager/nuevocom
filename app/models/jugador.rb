# == Schema Information
#
# Table name: jugadores
#
#  id         :integer          not null, primary key
#  equipo_id  :integer
#  nombre     :string(255)
#  apellidos  :string(255)
#  apodo      :string(255)
#  foto       :string(255)
#  precio     :float
#  dorsal     :integer
#  posicion   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Jugador < ActiveRecord::Base
  attr_accessible :apellidos, :apodo, :equipo_id, :foto, :nombre, :precio,:posicion,:dorsal

  belongs_to :equipo
  has_many :mercados
  has_many :plantilla_selecciones

  scope :once_titular, lambda {|seleccion_id|
    joins(:plantilla_selecciones).where('plantilla_selecciones.titular = ? AND plantilla_selecciones.seleccion_id = ?', true, seleccion_id)
  }

  scope :banquillo, lambda {|seleccion_id|
    joins(:plantilla_selecciones).where('(plantilla_selecciones.titular = ? OR plantilla_selecciones.titular is NULL) AND plantilla_selecciones.seleccion_id = ?', false, seleccion_id)
  }

  scope :plantilla, lambda {|seleccion_id|
      joins(:plantilla_selecciones).where('plantilla_selecciones.seleccion_id = ?', seleccion_id)
  }

  POSICIONES = {:portero => "Portero", :defensa => "Defensa", :medio => "Medio", :delantero => "Delantero"}

end
