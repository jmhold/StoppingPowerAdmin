class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :info

      t.timestamps
    end
  end
end
