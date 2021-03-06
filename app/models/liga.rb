# == Schema Information
#
# Table name: ligas
#
#  id                    :integer          not null, primary key
#  nombre                :string(255)
#  creador               :integer
#  logo                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  privacidad            :string(1)
#  password              :string(255)
#  maximo_miembros       :integer
#  presupuesto_inicial   :integer
#  num_jugadores_mercado :integer
#

class Liga < ActiveRecord::Base

  PRIVACIDAD = {:abierta => 'A', :privada => 'P'}
  NUM_MEMBERS = {:max => 20, :default => 8, :min => 2}
  PRESUPUESTO = {:max => 100000000, :min => 30000000, :default => 50000000}
  NUM_PLAYERS = {:max => 25, :default => 15, :min => 8}

  validates_presence_of :nombre
  validates_inclusion_of :privacidad, :in => PRIVACIDAD.values
  validates_presence_of :password, :if => :need_pwd?
  validates_numericality_of :maximo_miembros, :greater_than_or_equal_to =>  NUM_MEMBERS[:min], :less_than_or_equal_to => NUM_MEMBERS[:max]
  validates_numericality_of :num_jugadores_mercado, :greater_than_or_equal_to =>  NUM_PLAYERS[:min], :less_than_or_equal_to => NUM_PLAYERS[:max]
  validates_numericality_of :presupuesto_inicial, :greater_than_or_equal_to =>  PRESUPUESTO[:min], :less_than_or_equal_to => PRESUPUESTO[:max]



  DEFAULT_VALUES = {:privacidad => PRIVACIDAD[:abierta], :maximo_miembros => NUM_MEMBERS[:default], :presupuesto_inicial => PRESUPUESTO[:default], :num_jugadores_mercado => NUM_PLAYERS[:default]}

  attr_accessible :creador, :logo, :nombre, :privacidad, :maximo_miembros, :password, :presupuesto_inicial, :num_jugadores_mercado

  attr_accessor :emails_invitacion
  attr_accessible :emails_invitacion

  belongs_to :creador, :foreign_key => :creador, :class_name => User

  has_many :mercados
  has_many :selecciones
  has_many :messages

  scope :with_name_like, lambda { |str, tipo|
      {:conditions => ['lower(nombre) like ? AND privacidad = ?', %(%#{str.downcase}%),tipo]}
  }

  scope :with_name_equal, lambda { |str, tipo|
    {:conditions => ['nombre = ? AND privacidad = ?',str, tipo]}
  }


  scope :with_password_equal, lambda { |str, tipo|
    {:conditions => ['password = ? AND privacidad = ?',str, tipo]}
  }

  scope :with_name_or_creator_like, lambda { |str, tipo|
    {:conditions => ['(lower(nombre) like ? OR lower(creador) like ?) AND privacidad = ?', %(%#{str.downcase}%), %(%#{str.downcase}%), tipo]}
  }


  def need_pwd?
    privacidad != PRIVACIDAD[:abierta]
  end
end
