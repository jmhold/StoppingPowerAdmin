class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :info
      t.integer :test_id

      t.timestamps
    end
    
    add_index :images, :test_id
  end
end
