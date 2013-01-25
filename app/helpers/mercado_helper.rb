module MercadoHelper
  def valor_mercado_from_jugador(jug_id, mercados)
    mercados.select{|x| x.jugador_id == jug_id}.first.present?
  end
end
