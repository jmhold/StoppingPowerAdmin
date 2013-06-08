class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :study_id
      t.integer :study_image1_id
      t.integer :study_image2_id
      t.integer :page_number

      t.timestamps
    end
    
    add_index :pairs, :study_id
  end
end
