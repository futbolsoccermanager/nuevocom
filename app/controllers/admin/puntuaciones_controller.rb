module  Admin
  class PuntuacionesController < BaseController
    require "jobs/CalculoPuntoJugador"

    def show
      @equipos = Equipo.all

      num_jornada = params[:num_jornada] || '1'
      id_equipo = params[:num_equipo] || @equipos.first.id

      jugadores = Jugador.where(:equipo_id => id_equipo)

      puntos_je = PuntosJugador.puntos_je(num_jornada, jugadores.map{|j| j.id})

      @pjugador_pts = []

      puntos_je.each do |ptsj|
        jug_puntos = {}
        jug_puntos[:jugador_id] = ptsj[:jugador_id]
        jug_puntos[:nombre] = Jugador.find(jug_puntos[:jugador_id]).nombre
        jug_puntos[:posicion] = Jugador.find(jug_puntos[:jugador_id]).posicion

        jug_puntos[:puntos_total] = ptsj[:puntos_total]
        jug_puntos[:resultado_equipo] = ptsj[:resultado_equipo]
        jug_puntos[:goles] = ptsj[:goles]
        jug_puntos[:tarjetas] = ptsj[:tarjetas]
        jug_puntos[:sin_encajar] = ptsj[:sin_encajar]
        jug_puntos[:nota] = ptsj[:nota]
        jug_puntos[:destacado] = ptsj[:destacado]

        @pjugador_pts << jug_puntos
      end

      @pjugador_pts.sort! { |a,b| [Jugador::POSICIONES.key(a[:posicion]), a[:nombre]] <=> [Jugador::POSICIONES.key(b[:posicion]), b[:nombre]] }

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

    def cambiar_puntos
      @puntos  = PuntosJugador.find_by_jugador_id_and_jornada params[:jugador_id].to_i, params[:jornada]
    end

    def update
      CalculoPuntoJugador.update_player(params[:jornada], params[:jugador_id].to_i, params[:numero_goles].to_i, params[:tarjeta_amarilla].to_i, params[:tarjeta_roja].to_i, params[:nota])

      redirect_to admin_puntuaciones_path(:num_jornada => params[:jornada], :num_equipo => Jugador.find(params[:jugador_id]).equipo.id)
    end
  end
end
