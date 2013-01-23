

desc "Guardar el equipo titular por jornada"
task :equipo_jornada => :environment do
  threads = []
  equipos = Seleccion.all
  equipos.each do |equipo|
    threads << Thread.new do
      jugadores_ids = equipo.jugadores.map{|x| x.id}
      OnceJornada.create(:seleccion_id => equipo.id,:num_jornada => ENV["JORNADA"],:jugadores => jugadores_ids)
    end


  end
  threads.each(&:join)

end










