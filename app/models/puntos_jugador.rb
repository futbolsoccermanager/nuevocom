class PuntosJugador
  include MongoMapper::Document

  before_save :actualiza_total

  key :jugador_id, Integer
  key :num_jornada

  key :puntos_total, Integer

  key :resultado_equipo
  key :goles
  key :tarjetas
  key :sin_encajar
  key :nota
  key :destacado

  scope :puntos_je, lambda { |jornada, jugadores|
    where(:jornada => jornada, :jugador_id =>  jugadores)
    #{:conditions => ["num_jornada = ? and jugador_id IN  (?) ", jornada, jugadores]}
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

  private
  def actualiza_total
    self.puntos_total = (resultado_equipo || 0) + (goles || 0) + (tarjetas || 0) + (sin_encajar || 0) + (nota || 0) + (destacado || 0)
  end
end