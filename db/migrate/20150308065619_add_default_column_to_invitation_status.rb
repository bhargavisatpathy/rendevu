class AddDefaultColumnToInvitationStatus < ActiveRecord::Migration
  def up
    change_column :invitations, :status, :string, :default => "open"
  end

  def down
    change_column :invitations, :status, :string, :default => nil
  end
end
