class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.datetime :time
      t.integer :rank
      t.references :plan, index: true

      t.timestamps null: false
    end
    add_foreign_key :options, :plans
  end
end
