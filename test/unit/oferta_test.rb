# == Schema Information
#
# Table name: oferta
#
#  id           :integer          not null, primary key
#  seleccion_id :integer
#  mercado_id   :integer
#  valor        :float
#  fecha        :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  estado       :string(255)
#  fecha_fin    :date
#

require 'test_helper'

class OfertaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
