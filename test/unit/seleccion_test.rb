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

require 'test_helper'

class SeleccionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
