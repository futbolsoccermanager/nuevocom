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
  attr_accessible :creador, :logo, :nombre
end
