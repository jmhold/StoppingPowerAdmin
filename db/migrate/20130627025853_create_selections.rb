class CreateSelections < ActiveRecord::Migration
  def up
    create_table :selections do |t|
      t.integer :study_image_id
      t.integer :result_id

      t.timestamps
    end
    remove_column :study_images, :click_count
  end
  
  def down
    drop_table :selections
    add_column :study_images, :click_count, :integer
  end
end
