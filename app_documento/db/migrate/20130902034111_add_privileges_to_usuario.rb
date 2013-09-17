class AddPrivilegesToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :transcriptor, :boolean, :default => false
    add_column :usuarios, :responsable, :boolean, :default => false
  end
end
