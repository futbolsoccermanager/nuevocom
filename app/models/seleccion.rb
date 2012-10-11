class Seleccion < ActiveRecord::Base
  attr_accessible :escudo, :user_id, :liga_id, :nombre

  belongs_to :user
  belongs_to :liga
end
