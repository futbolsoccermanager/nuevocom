class PuntosJugador
  include MongoMapper::Document

  before_save :actualiza_total

  key :jugador_id, Integer
  key :jornada

  key :puntos_total, Float

  key :resultado_equipo
  key :goles
  key :tarjetas
  key :sin_encajar
  key :nota
  key :destacado

  scope :puntos_je, lambda { |jornada, jugadores|
    where(:jornada => jornada, :jugador_id =>  jugadores)
  }

  scope :puntos_todos, lambda { |jugador_id|
    where(:jugador_id =>  jugador_id)
  }


  def codigo_resultado
    return 'G' if resultado_equipo == 2
    return 'E' if resultado_equipo == 1
    'P'
  end

  def codigo_porteria
    return '1' if (self.sin_encajar || 0) > 0
    nil
  end

  def rojas
    return 1 if tarjetas == -4
    0
  end

  def amarillas
    return 2 if tarjetas == -2
    0
  end

  def self.total_puntuacion(jugador_id)
      self.all(:jugador_id => jugador_id).inject(0){|sum,x| sum  + (x.puntos_total || 0) }
  end

  private
  def actualiza_total
    if nota.present?
      self.puntos_total = (resultado_equipo || 0) + (goles || 0) + (tarjetas || 0) + (sin_encajar || 0) + (nota || 0) + (destacado || 0)
    else
      self.puntos_total = nil
    end
  end
end