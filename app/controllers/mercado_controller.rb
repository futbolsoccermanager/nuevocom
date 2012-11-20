class MercadoController < ApplicationController
  def index
    seleccion = Seleccion.find(params[:id_seleccion])

    not_found if current_user != seleccion.user

    liga_id = seleccion.liga_id
    @jugadores_mercado = Mercado.where(:liga_id => liga_id)

    @ofertas = seleccion.ofertas

    #todo mientras no se actualicen precios se mete a pelo
    @jugadores_mercado.each do |jm|
      j = jm.jugador
      if j.precio.blank?
        j.precio = rand * 50000000
        j.save
      end
    end
  end

  def create_ofertas

    params.select{|par, val| par.starts_with?('oferta') && val.present?}.each do |puja|
      oferta = Oferta.new :mercado_id => puja.first.delete('oferta_'), :seleccion_id => current_user.current_seleccion(session).id, :valor => puja.last.to_f

      oferta.save_if_valid

    end

    respond_to do |format|
      format.js
    end

  end
end
