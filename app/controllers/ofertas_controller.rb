class OfertasController < ApplicationController
  def index
    @ofertas = Oferta.includes(:mercado).find_all_by_seleccion_id(current_user.current_seleccion(session))
  end

  # detalle de una oferta
  def show
    @oferta = Oferta.find params[:id]
  end
end
