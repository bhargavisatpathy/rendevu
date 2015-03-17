class AddColumnToOption < ActiveRecord::Migration
  def change
    add_column :options, :selected, :boolean, default: false
  end
end
