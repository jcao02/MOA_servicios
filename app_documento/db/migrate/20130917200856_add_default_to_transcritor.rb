class AddDefaultToTranscritor < ActiveRecord::Migration
  def change
    change_column :usuarios, :transcriptor, :boolean, :default => true
  end
end
