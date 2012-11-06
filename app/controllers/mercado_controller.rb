class MercadoController < ApplicationController
  def index
    seleccion = Seleccion.find(params[:id_seleccion])

    not_found if current_user != seleccion.user

    liga_id = seleccion.liga_id
    @jugadores_mercado = Mercado.where(:liga_id => liga_id)
  end
end
