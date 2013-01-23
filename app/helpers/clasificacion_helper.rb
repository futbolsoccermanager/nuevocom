module ClasificacionHelper

  def puntos_jornada_seleccion(puntuaciones, jornada, seleccion)
    puntuaciones[seleccion]["jornada_#{jornada}".to_sym]
  end

  def puntos_total_seleccion(puntuaciones, seleccion)
    puntuaciones[seleccion][:total]
  end

end
