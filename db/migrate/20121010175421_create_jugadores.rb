class CreateJugadores < ActiveRecord::Migration
  def change
    create_table :jugadores do |t|
      t.integer :equipo_id
      t.string :nombre
      t.string :apellidos
      t.string :apodo
      t.string :foto
      t.float :precio
      t.integer :dorsal
      t.string :posicion
      t.timestamps
    end
  end
end
