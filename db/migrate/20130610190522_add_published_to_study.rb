class AddPublishedToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :published, :boolean
  end
end
