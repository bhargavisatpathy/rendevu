class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.string :status
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :plans, :users
  end
end
