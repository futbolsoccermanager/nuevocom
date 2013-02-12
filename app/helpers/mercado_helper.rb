module MercadoHelper
  def valor_mercado_from_jugador(jug_id, mercados)
    mercados.select{|x| x.jugador_id == jug_id}.first.present?
  end

  def seleccion_mercado_jugador(jugador, seleccion)
    return nil if jugador.plantilla_selecciones.blank?

    jugador.plantilla_selecciones.select{ |x| x.seleccion.liga_id == seleccion.liga_id}.first.try(:seleccion)
  end
end
