# == Schema Information
#
# Table name: mercados
#
#  id              :integer          not null, primary key
#  jugador_id      :integer
#  liga_id         :integer
#  fecha_inclusion :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Mercado < ActiveRecord::Base
  attr_accessible :fecha_inclusion, :jugador_id, :liga_id

  belongs_to :liga
  belongs_to :jugador
end
