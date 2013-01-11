class CalculoPuntoJugador

  def self.update_player(jornada, jugador_id, numero_goles, tarjeta_amarilla, tarjeta_roja, nota)

    pj = PuntosJugador.find_by_jugador_id_and_jornada jugador_id, jornada
    jugador = Jugador.find(jugador_id)

    pj.goles = self.puntos_goles(jugador.posicion, numero_goles)

    pj.tarjetas = -2 if tarjeta_amarilla > 1
    pj.tarjetas = -4 if tarjeta_roja > 0

    pj.nota = nota.try(:to_f)

    pj.save

  end

  def self.puntos_goles(posicion, goles)
    case posicion
      when Jugador::POSICIONES[:portero]
        return goles*5
      when Jugador::POSICIONES[:defensa]
        return goles*4
      when Jugador::POSICIONES[:medio]
        return goles*3
      when Jugador::POSICIONES[:delantero]
        return goles*2
      else
        return goles
    end
  end

  def self.resultado_equipo(jornada, equipo, resultado, porteria_vacia)
    jugadores = Jugador.where(:equipo_id => equipo)

    case resultado
      when 'E'
        p_resultado = 1
      when 'G'
        p_resultado = 2
      else
        p_resultado = 0
    end


    jugadores.each do |j|
      pj = PuntosJugador.find_or_create_by_jugador_id_and_jornada j.id, jornada
      pj.resultado_equipo = p_resultado

      if porteria_vacia && j.posicion == Jugador::POSICIONES[:portero]
        pj.sin_encajar = 2
      elsif porteria_vacia && j.posicion == Jugador::POSICIONES[:defensa]
        pj.sin_encajar = 1
      else
        pj.sin_encajar = 0
      end
      pj.save
    end

  end
end