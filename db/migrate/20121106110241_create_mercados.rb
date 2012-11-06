class CreateMercados < ActiveRecord::Migration
  def change
    create_table :mercados do |t|
      t.integer :jugador_id
      t.integer :liga_id
      t.date :fecha_inclusion

      t.timestamps
    end
  end
end
