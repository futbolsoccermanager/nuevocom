class AddLigaToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :liga_id, :integer
  end
end
