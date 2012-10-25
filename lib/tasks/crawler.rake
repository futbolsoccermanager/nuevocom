require 'nokogiri'
require 'open-uri'
if Rails.env.development?
require 'anemone'
desc "Extraer instalaciones deportivas"
task :crawler => :environment do
  f = File.open("#{Rails.root}/test/crawler/urls.txt", "w")
  Anemone.crawl("http://www.marca.com/deporte/futbol") do |anemone|
    anemone.on_every_page do |page|
      page.links.each do |link|
        if link.to_s.include?("http://www.marca.com/deporte/futbol/equipos/") && link.to_s.include?("datos.html")
          f.write link.to_s
          f.write "\n"
        end
      end
    end
  end

end



end





