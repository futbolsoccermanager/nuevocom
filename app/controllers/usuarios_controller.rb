class UsuariosController < ApplicationController
  def index
    @siguiendo = current_user.followables
  end

  def show
  end
end
