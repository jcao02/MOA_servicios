class CreateLogproductos < ActiveRecord::Migration
  def change
    create_table :logproductos do |t|
      t.integer :usuario_id
      t.integer :producto_id
      t.string :tipo

      t.timestamps
    end
  end
end
