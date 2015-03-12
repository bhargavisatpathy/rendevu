class AddDefaultColumnToOptionRank < ActiveRecord::Migration
  def up
    change_column :options, :rank, :integer, :default => 0
  end

  def down
    change_column :options, :rank, :integer, :default => nil
  end
end
