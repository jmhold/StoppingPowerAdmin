class AddCaptions < ActiveRecord::Migration
  def change
    add_column :studies, :caption, :string
    add_column :images, :caption, :string
    add_column :images, :image_type, :string, :default => "proposed"
  end
end
