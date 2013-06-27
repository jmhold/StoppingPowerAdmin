class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :first_name
      t.string :last_name
      t.string :group_id
      t.string :gender
      t.integer :study_id

      t.timestamps
    end
  end
end
