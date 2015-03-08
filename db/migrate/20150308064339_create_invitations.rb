class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :name
      t.string :status
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :invitations, :users
  end
end
