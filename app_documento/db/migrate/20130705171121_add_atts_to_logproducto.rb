class AddAttsToLogproducto < ActiveRecord::Migration
  def change
    add_column :logproductos, :nusuario, :string
    add_column :logproductos, :nproducto, :string
  end
end
