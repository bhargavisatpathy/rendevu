class AddColumnToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :time, :datetime
  end
end
