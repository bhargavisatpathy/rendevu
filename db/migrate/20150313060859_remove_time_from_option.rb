class RemoveTimeFromOption < ActiveRecord::Migration
  def change
    remove_column :options, :time, :datetime
  end
end
