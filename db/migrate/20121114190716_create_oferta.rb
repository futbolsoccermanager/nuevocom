class CreateOferta < ActiveRecord::Migration
  def change
    create_table :oferta do |t|
      t.integer :seleccion_id
      t.integer :mercado_id
      t.float :valor
      t.date :fecha

      t.timestamps
    end
  end
end
