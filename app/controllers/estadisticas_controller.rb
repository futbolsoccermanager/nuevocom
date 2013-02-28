class EstadisticasController < ApplicationController
  def dato_jugador
    @jugador = Jugador.find params[:jugador_id]
  end
end
