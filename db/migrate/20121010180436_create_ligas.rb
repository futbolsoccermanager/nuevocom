class CreateLigas < ActiveRecord::Migration
  def change
    create_table :ligas do |t|
      t.string :nombre
      t.integer :creador
      t.string :logo

      t.timestamps
    end
  end
end
