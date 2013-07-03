class CreateLogdocumentos < ActiveRecord::Migration
  def change
    create_table :logdocumentos do |t|
      t.integer :usuario_id
      t.integer :documento_id
      t.string :tipo

      t.timestamps
    end
  end
end
