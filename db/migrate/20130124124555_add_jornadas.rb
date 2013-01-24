class AddJornadas < ActiveRecord::Migration
  def change
        create_table :jornadas do |t|
          t.integer :num_jornada
          t.datetime :fecha_comienzo
          t.datetime :fecha_fin
          t.boolean :calculos_hechos
          t.boolean :actual
          t.timestamps
        end
    end
end
