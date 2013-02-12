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

  def css_once_titular(tactica, position)
    str = ''
    case position
      when Jugador::POSICIONES[:portero]
        str << "margin-left:150px;" if tactica == Seleccion::TACTICA_HASH[:defensa]
        str << "margin-left:110px;" if tactica != Seleccion::TACTICA_HASH[:defensa]
      when Jugador::POSICIONES[:defensa]
        str << "margin-left:20px;" if tactica == Seleccion::TACTICA_HASH[:defecto]
        str << "margin-left:20px;" if tactica == Seleccion::TACTICA_HASH[:ataque]
        str << "margin-left:40px;" if tactica == Seleccion::TACTICA_HASH[:medio]
        str << "margin-left:10px;" if tactica == Seleccion::TACTICA_HASH[:defensa]

      when Jugador::POSICIONES[:medio]
        str << "margin-left:20px;" if tactica == Seleccion::TACTICA_HASH[:defecto]
        str << "margin-left:50px;" if tactica == Seleccion::TACTICA_HASH[:ataque]
        str << "margin-left:10px;" if tactica == Seleccion::TACTICA_HASH[:medio]
        str << "margin-left:40px;" if tactica == Seleccion::TACTICA_HASH[:defensa]

      when Jugador::POSICIONES[:delantero]
        str << "margin-left:90px;" if tactica == Seleccion::TACTICA_HASH[:defecto]
        str << "margin-left:50px;" if tactica == Seleccion::TACTICA_HASH[:ataque]
        str << "margin-left:150px;" if tactica == Seleccion::TACTICA_HASH[:medio]
        str << "margin-left:150px;" if tactica == Seleccion::TACTICA_HASH[:defensa]
    end
    return str
  end


  def tacticas_equipo
    (Seleccion::TACTICA_HASH).map{|name, value| value + ".jpg"}
  end


  def convertir_tactica(tactica)
    tactica.gsub('.jpg','').gsub("_","-")
  end

end
