class AddDefaultColumnToplanStatus < ActiveRecord::Migration
  def up
    change_column :plans, :status, :string, :default => "open"
  end

  def down
    change_column :plans, :status, :string, :default => nil
  end
end
