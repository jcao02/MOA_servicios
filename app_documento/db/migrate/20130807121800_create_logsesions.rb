class CreateLogsesions < ActiveRecord::Migration
  def change
    create_table :logsesions do |t|
      t.integer :usuario_id
      t.integer :superu_id
      t.string :tipo
      t.string :nusuario
      t.string :nsuperu

      t.timestamps
    end
  end
end
