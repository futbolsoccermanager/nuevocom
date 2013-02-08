class UsuariosController < ApplicationController
  def index
    @siguiendo = current_user.followees(User)
    @seguidores = current_user.followers(User)
  end

  def show
  end
end
