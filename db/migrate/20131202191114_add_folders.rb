class AddFolders < ActiveRecord::Migration
  def up
    create_table :folders do |t|
      t.string :name, :unique => true
    end
    
    Folder.create :name => "Default", :id => 1
    
    add_column :images, :folder_id, :integer, :default => 1
  end
  
  def down
    drop_table :folders
    remove_column :images, :folder_id
  end
end