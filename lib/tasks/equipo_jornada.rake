

desc "Guardar el equipo titular por jornada"
task :equipo_jornada => :environment do
  equipos = Seleccion.all
  equipos.each do |equipo|
    jugadores_ids = PlantillaSeleccion.all(:conditions => ["seleccion_id = ? and titular = ?", equipo.id, 1]).map{|x| x.jugador_id}
    OnceJornada.create(:seleccion_id => equipo.id,:jornada => ENV["JORNADA"],:jugadores => jugadores_ids)
  end




end










