class AddColumnToOptions < ActiveRecord::Migration
  def change
    add_column :options, :venue_id, :string
  end
end
