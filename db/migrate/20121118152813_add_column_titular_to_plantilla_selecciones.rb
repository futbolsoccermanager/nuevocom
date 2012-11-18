class AddColumnTitularToPlantillaSelecciones < ActiveRecord::Migration
  def change
    add_column :plantilla_selecciones, :titular, :boolean
  end
end
