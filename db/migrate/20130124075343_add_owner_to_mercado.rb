class AddOwnerToMercado < ActiveRecord::Migration
  def change
    add_column :mercados, :seleccion_id, :integer
  end
end
