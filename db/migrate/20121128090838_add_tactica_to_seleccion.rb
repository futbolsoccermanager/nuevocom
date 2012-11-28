class AddTacticaToSeleccion < ActiveRecord::Migration
  def change
      add_column :selecciones, :tactica, :string, :default => "4_4_2"
  end
end
