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

  def escudo_equipo(nombre_equipo = nil)
    nombre_equipo = "base_player" if nombre_equipo.nil?
    str =  "background-image:url('#{image_path("escudos/#{nombre_equipo}.png")}');"
    str << "background-repeat: no-repeat;"
    str << "padding-left: 14px;"
    str << "background-size: 50px 50px;"
    str << "height: 60px;width:60px;"
    return str
  end



end
