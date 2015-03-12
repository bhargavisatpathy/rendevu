class AddColumnToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :voting_token, :string
  end
end
