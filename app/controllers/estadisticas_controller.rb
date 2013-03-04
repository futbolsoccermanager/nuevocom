class EstadisticasController < ApplicationController
  def dato_jugador
    @jugador = Jugador.find params[:jugador_id]
    @puntos_jornadas = Hash[*PuntosJugador.puntos_todos(@jugador.id).map{|x| [x.jornada, x.puntos_total]}.flatten]
  end
end
