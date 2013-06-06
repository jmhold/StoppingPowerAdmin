class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string :name
      t.timestamps
    end
    
    add_index :studies, :name, :unique => true
  end
end
