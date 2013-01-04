class AddEstadoToOferta < ActiveRecord::Migration
  def change
    add_column :oferta, :estado, :string
    add_column :oferta, :fecha_fin, :date
  end
end
