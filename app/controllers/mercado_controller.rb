class MercadoController < ApplicationController
  def index
    liga_id = Seleccion.find(params[:id_seleccion]).liga_id
    @jugadores_mercado = Mercado.where(:liga_id => liga_id)
  end
end
