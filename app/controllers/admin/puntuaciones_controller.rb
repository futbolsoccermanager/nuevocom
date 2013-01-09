module  Admin
  class PuntuacionesController < BaseController
    require "jobs/CalculoPuntoJugador"

    def show
      @equipos = Equipo.all

      num_jornada = params[:num_jornada] || 1
      id_equipo = params[:num_equipo] || @equipos.first.id
      @jugadores = Jugador.where(:equipo_id => id_equipo)

      @puntos_je = PuntosJugador.puntos_je(num_jornada, @jugadores.map{|j| j.id})
    end

    def puntos_equipos
      @equipos = Equipo.all

      @jornada = params[:jornada] || 1
      @puntos_guardados = {}

      @equipos.map{|e| e.jugadores.select{|j| j.posicion == Jugador::POSICIONES[:portero]}.first}.each do |jug|
        pj = PuntosJugador.find_by_jugador_id_and_jornada jug.id, @jornada.to_s
        if pj.present?
          @puntos_guardados[jug.equipo.id] = pj.codigo_resultado
          @puntos_guardados["#{jug.equipo.id}_p0"] = pj.codigo_porteria
        end

      end



    end

    def create
      jornada = params[:jornada]
      equipos = Equipo.all

      equipos.each do |e|
        if params[e.id.to_s].present? || params["#{e.id.to_s}_p0"].present?
          CalculoPuntoJugador.resultado_equipo jornada, e.id,  params[e.id.to_s], params["#{e.id.to_s}_p0"] == '1'
        end
      end

      respond_to do |format|
        format.js
      end
    end
  end
end
