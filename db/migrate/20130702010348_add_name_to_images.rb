class AddNameToImages < ActiveRecord::Migration
  def change
    add_column :studies, :active, :boolean, :default => false
    add_column :images, :name, :string
  end
end
