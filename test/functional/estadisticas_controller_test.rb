require 'test_helper'

class EstadisticasControllerTest < ActionController::TestCase
  test "should get dato_jugador" do
    get :dato_jugador
    assert_response :success
  end

end
