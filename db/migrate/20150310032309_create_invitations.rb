class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.boolean :voted
      t.references :plan, index: true
      t.references :friend, index: true

      t.timestamps null: false
    end
    add_foreign_key :invitations, :plans
    add_foreign_key :invitations, :friends
  end
end
