class AddStudyOptions < ActiveRecord::Migration
  def change
    add_column :studies, :instructions, :string, :default => "Touch the image that gets your attention first. You have two seconds to make your choice, as indicated by the time clock above the images."
    add_column :studies, :timer, :float, :default => 2
    add_column :studies, :randomize, :boolean, :default => false
  end
end
