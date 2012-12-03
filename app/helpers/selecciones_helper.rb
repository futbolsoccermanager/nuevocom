module SeleccionesHelper


  def jugadores_titulares_por_posicion(tactica, jugadores, position)
    jugadores = [] unless jugadores.present?
    tactica = tactica.split("_")
    num_players_tactica = 0
    case position
      when Jugador::POSICIONES[:defensa]
        num_players_tactica = tactica[0].to_i
      when Jugador::POSICIONES[:medio]
        num_players_tactica = tactica[1].to_i
      when Jugador::POSICIONES[:delantero]
        num_players_tactica = tactica[2].to_i
    end
    num_titulares = jugadores.length
    num_jugadores_faltan = num_players_tactica - num_titulares

    i = 0
    while i < num_jugadores_faltan
      jugadores << nil
      i = i + 1
    end

    return jugadores
  end

  def escudo_equipo(id_equipo = nil)
    id_equipo = "base_player" if id_equipo.nil?
    str =  "background-image:url('#{image_path("escudos/#{id_equipo}.png")}');"
    str << "background-repeat: no-repeat;"
    str << "background-position: 0px 5px;"
    str << "padding-left: 14px;"
    str << "background-size: 90px 90px;"
    str << "height: 100px;width:100px;"
    return str
  end

end
