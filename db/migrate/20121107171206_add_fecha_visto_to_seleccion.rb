class AddFechaVistoToSeleccion < ActiveRecord::Migration
  def change
    add_column :selecciones, :fecha_visto, :date
  end
end
