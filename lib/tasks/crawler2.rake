require 'nokogiri'
require 'open-uri'
if Rails.env.development?
require 'anemone'
desc "Extraer jugadores"
task :crawler2 => :environment do
  equipos_procesados = []
  f = File.open("#{Rails.root}/test/crawler/urls.txt").read

  f.each_line do |line|
    puts "------------------------- " + equipos_procesados.inspect
    url = line
    nombre_equipo = line.gsub("http://www.marca.com/deporte/futbol/equipos/",'')
    nombre_equipo = nombre_equipo.gsub("/datos.html",'')
    if !equipos_procesados.include?(nombre_equipo)
      equipos_procesados << nombre_equipo
      equipo = Equipo.create(:nombre => nombre_equipo.gsub("\n",''))

      doc = Nokogiri::HTML(open(url))
      jugadores = doc.xpath('//div[contains(@class, "plantilla")]//ul').children
      jugadores.each do |jug|
        dorsal = ""
        jugador = ""
        position = ""
        begin
          jug.children.first.children.each do |dato|
            case dato.name
              when "img"
                begin
                  puts dato.attributes["title"].text.inspect
                  dorsal = dato.attributes["title"].text.gsub("Dorsal ",'')
                rescue Exception => e
                  puts "#{e}"
                end
              when "p"
                jugador = dato.text if !dato["class"].present?
                position = dato.text if dato["class"].present?
                puts dato.text
            end
          end
          if !jugador.blank?
            Jugador.create(:equipo_id => equipo.id,:nombre => jugador,:dorsal => dorsal.to_i, :posicion => position.to_s)
          end

        rescue Exception => e
         puts "#{e}"
        end

      end

    end
  end


end



end





