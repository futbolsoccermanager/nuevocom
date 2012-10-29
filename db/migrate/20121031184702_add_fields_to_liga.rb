class AddFieldsToLiga < ActiveRecord::Migration
  def change
    add_column :ligas, :privacidad, :char
    add_column :ligas, :password, :string
    add_column :ligas, :maximo_miembros, :integer
    add_column :ligas, :presupuesto_inicial, :integer
    add_column :ligas, :num_jugadores_mercado, :integer
  end
end
