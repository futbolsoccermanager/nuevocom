class CreatePlantilla < ActiveRecord::Migration
  def change
      create_table :plantilla_selecciones do |t|
        t.integer :seleccion_id
        t.integer :jugador_id

        t.timestamps
      end
  end
end
