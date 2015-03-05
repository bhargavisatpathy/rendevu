class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :places, :categories
  end
end
