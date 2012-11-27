# == Schema Information
#
# Table name: oferta
#
#  id           :integer          not null, primary key
#  seleccion_id :integer
#  mercado_id   :integer
#  valor        :float
#  fecha        :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Oferta < ActiveRecord::Base
  attr_accessible :fecha, :mercado_id, :seleccion_id, :valor

  attr_accessor :mercado


  belongs_to :mercado
  belongs_to :seleccion

  ## valida que la liga sea valida (id mercado(jugador) correcto, ...)
  def save_if_valid

    return false if Mercado.find(self.mercado_id).liga != self.seleccion.liga

    self.fecha = Time.now

    antigua = Oferta.where(:mercado_id => self.mercado_id, :seleccion_id => self.seleccion_id).first
    if  antigua.present?
      antigua.valor = self.valor
      antigua.fecha = Time.now
      antigua.save

      antigua
    else
      self.save
      self
    end
  end
end
