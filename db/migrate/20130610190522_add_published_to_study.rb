class AddPublishedToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :published, :boolean, :default => false
  end
end
