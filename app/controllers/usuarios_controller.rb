class UsuariosController < ApplicationController

  def index
    @siguiendo = current_user.followees(User)
    @seguidores = current_user.followers(User)
  end

  def search_usuario
    results = User.busqueda_texto params[:term]
    array_users = results.map {|u| {nombre: u.username, value: u.username, code: u.id}}
    results = array_users.to_json
    respond_to do |format|
      format.json {
        render :json => results
      }
    end

  end

  def lista_usuarios
    @lista_usuarios = User.busqueda_texto params[:busca_usuario] || ''
  end

  def seguir_usuario
    @usuario = User.find params[:usuario_id]
    current_user.follows?(@usuario)? current_user.unfollow!(@usuario) : current_user.follow!(@usuario)
  end

  def show
  end

end
