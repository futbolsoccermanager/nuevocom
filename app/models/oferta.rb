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
#  estado       :string(255)
#  fecha_fin    :date
#

class Oferta < ActiveRecord::Base
  attr_accessible :fecha, :mercado_id, :seleccion_id, :valor, :estado

  #attr_accessor :mercado


  belongs_to :mercado
  belongs_to :seleccion

  PENDIENTE =  'P'
  ACEPTADA = 'A'
  CADUCADA = 'C'
  RECHAZADA = 'R'
  CANCELADA = 'X'


  STATUSES = {
      :pendiente => PENDIENTE,
      :aceptada => ACEPTADA,
      :caducada => CADUCADA,
      :rechazada => RECHAZADA,
      :cancelada => CANCELADA
  }

  STATUSES.each do |status, value|
      define_method :"#{status}?" do
          self.estado == value
      end
      define_method :"#{status}!" do
          self.estado = value
      end
  end

  class <<self
    STATUSES.each do |status_name, value|
       define_method "all_#{status_name}" do
         find(:all, :conditions => ["estado == ?", value])
       end
       define_method "not_all_#{status_name}" do
         find(:all, :conditions => ["estado <> ?", value])
       end
    end
  end


  ## valida que la liga sea valida (id mercado(jugador) correcto, ...)
  ## si ya existe, se actualiza el valor
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
