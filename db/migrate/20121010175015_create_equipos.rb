class CreateEquipos < ActiveRecord::Migration
  def change
    create_table :equipos do |t|
      t.string :nombre
      t.string :logo

      t.timestamps
    end
  end
end
