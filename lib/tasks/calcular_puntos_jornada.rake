

desc "Calcula la puntuacion total por equipo"
task :calcular_puntos_jornada => :environment do


  jornada = ENV["JORNADA"]

  equipos = OnceJornada.find_all_by_jornada jornada
  p equipos
  equipos = [equipos] if equipos.class != Array
  equipos.each do |equipo|
    total = 0
    p equipo.jugadores.class.to_s
    puntos_je = PuntosJugador.all(:jornada => jornada, :jugador_id =>  equipo.jugadores)
    p puntos_je
    puntos_je.each do |j|
      total += (j.puntos_total || 0)
    end
    equipo.puntuacion = total

    equipo.save!
  end



end










