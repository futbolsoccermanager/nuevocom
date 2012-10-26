# == Schema Information
#
# Table name: equipos
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  logo       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Equipo < ActiveRecord::Base
  attr_accessible :logo, :nombre
end
