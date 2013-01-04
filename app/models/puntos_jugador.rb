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

  private
  def actualiza_total
    self.puntos_total = resultado_equipo + goles + tarjetas + sin_encajar + nota + destacado
  end
end