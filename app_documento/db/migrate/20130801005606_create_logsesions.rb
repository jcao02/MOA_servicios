class CreateLogsesions < ActiveRecord::Migration
  def change
    create_table :logsesions do |t|
      t.integer :usuario_id
      t.string :tipo

      t.timestamps
    end
  end
end
