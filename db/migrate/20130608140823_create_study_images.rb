class CreateStudyImages < ActiveRecord::Migration
  def change
    create_table :study_images do |t|
      t.integer :study_id
      t.integer :image_id
      t.integer :click_count

      t.timestamps
    end
    
    add_index :study_images, [:study_id, :image_id], :unique => true
  end
end
