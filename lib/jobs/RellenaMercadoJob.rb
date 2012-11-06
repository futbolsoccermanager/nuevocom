class RellenaMercadoJob
  # TODO hacerlo asincrono para la llamada desde la creacion de liga

  def self.relleno(liga_id)
    liga = Liga.find liga_id

    arr_jugadores = Jugador.select([:id])
    while liga.num_jugadores_mercado > liga.mercados.count
      idnuevo = arr_jugadores.sample.id
      if Mercado.where(:liga_id => liga_id, :jugador_id => idnuevo).blank?
        mercado_nuevo = Mercado.new(:liga_id => liga_id, :jugador_id => idnuevo, :fecha_inclusion => Time.now)
        mercado_nuevo.save
      end
    end
  end
end


