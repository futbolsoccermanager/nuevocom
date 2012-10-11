class CreateSelecciones < ActiveRecord::Migration
  def change
    create_table :selecciones do |t|
      t.integer :user_id
      t.string :nombre
      t.string :escudo
      t.integer :liga_id

      t.timestamps
    end
  end
end
