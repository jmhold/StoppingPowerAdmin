class AddWarmupPairsToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :warmup_pairs, :integer, :default => 0
  end
end
