class CreateLogtramites < ActiveRecord::Migration
  def change
    create_table :logtramites do |t|
      t.integer :usuario_id
      t.integer :tramite_id
      t.string :tipo

      t.timestamps
    end
  end
end
