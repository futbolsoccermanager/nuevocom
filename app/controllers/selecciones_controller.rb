class SeleccionesController < ApplicationController

  def new
    @seleccion = Seleccion.new(:user_id => current_user.id)
  end
end
