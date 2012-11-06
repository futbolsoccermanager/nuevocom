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

require 'test_helper'

class MercadoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
