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

require 'test_helper'

class LigaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
