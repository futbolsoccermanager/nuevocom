class OfertaHistorico < ActiveRecord::Base

  include MongoMapper::Document

  key :mercado_id, Integer
  key :seleccion_id, Integer
  key :valor
  key :estado
  key :fecha, Date
  key :fecha_fin, Date



end
