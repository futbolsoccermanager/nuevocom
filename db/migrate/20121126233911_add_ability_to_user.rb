class AddAbilityToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :premium, :boolean
  end
end
