class CalculoPuntoJugador

  def self.calificacion(jornada, nota, jugador_id)

    pj = PuntosJugador.find_by_jugador_id_and_jornada jugador_id, jornada

    pj.nota = nota
    pj.save

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