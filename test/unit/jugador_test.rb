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

require 'test_helper'

class JugadorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
