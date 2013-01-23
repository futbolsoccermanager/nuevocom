class ClasificacionController < ApplicationController
  def index
    liga = current_user.current_seleccion(session).liga

    @equipos_liga = liga.selecciones

    @puntos_liga = {}
    @equipos_liga.map{|x| x.id}.each do |idsele|
      hequipo = {}

      puntos = OnceJornada.all(:seleccion_id => idsele)
      total = 0.0
      puntos.each do |pj|
        total += pj.puntuacion
        hequipo["jornada_#{pj.jornada}".to_sym] = pj.puntuacion
      end
      hequipo[:total] = total
      @puntos_liga[idsele] = hequipo
    end


  end
end
