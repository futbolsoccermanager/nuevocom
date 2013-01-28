desc "Guardar el historico de ofertas que no esten en estado P para tener limpia la tabla de ofertas"
task :backup_ofertas_historico => :environment do

  ofertas = Oferta.not_all_pendiente

  ofertas_ids = ofertas.map {|of| of.id}

  ofertas.each do |oferta|
   OfertaHistorico.create(:seleccion_id => oferta.seleccion_id,
                          :mercado_id => oferta.mercado_id,
                          :valor => oferta.valor,
                          :fecha => oferta.fecha,
                          :fecha_fin => oferta.fecha_fin,
                          :estado => oferta.estado)

   Oferta.delete_all ["id in (?)",ofertas_ids]
  end

end










