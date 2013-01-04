class CalculoPuntoJugador

  def self.calificacion(jornada, nota, jugador_id)

    pj = PuntosJugador.find_by_jugador_id_and_jornada jugador_id, jornada

    pj.nota = nota
    pj.save

  end
end