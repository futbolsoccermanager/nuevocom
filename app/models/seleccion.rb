# == Schema Information
#
# Table name: selecciones
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  nombre      :string(255)
#  escudo      :string(255)
#  liga_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  fecha_visto :date
#  tactica     :string(255)      default("4_4_2")
#

class Seleccion < ActiveRecord::Base
  attr_accessible :escudo, :user_id, :liga_id, :nombre, :fecha_visto

  validates_presence_of :liga_id, :user_id

  belongs_to :user
  belongs_to :liga
  has_many :plantilla_selecciones
  has_many :jugadores, :through => :plantilla_selecciones
  has_many :ofertas




end
