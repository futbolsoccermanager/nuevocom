# == Schema Information
#
# Table name: ligas
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  creador    :integer
#  logo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Liga < ActiveRecord::Base

  PRIVACIDAD = {:abierta => 'A', :publica => 'P', :restringida => 'R'}
  NUM_MEMBERS = {:max => 20, :default => 8}
  PRESUPUESTO = {:max => 100000000, :min => 30000000, :default => 50000000}
  NUM_PLAYERS = {:max => 25, :default => 15, :min => 8}

  DEFAULT_VALUES = {:privacidad => PRIVACIDAD[:abierta], :maximo_miembros => NUM_MEMBERS[:default], :presupuesto_inicial => PRESUPUESTO[:default], :num_jugadores_mercado => NUM_PLAYERS[:default]}

  attr_accessible :creador, :logo, :nombre, :privacidad, :maximo_miembros, :password, :presupuesto_inicial, :num_jugadores_mercado

  attr_accessor :emails_invitacion

  belongs_to :creador, :foreign_key => :creador, :class_name => User
end
