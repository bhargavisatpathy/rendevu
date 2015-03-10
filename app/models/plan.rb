class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :friends, through: :invitations

  validates :name, presence: true
  #before_destroy { |plan| plan.invitations.destroy_all}

  def add_friends(friend_ids)
    friend_ids.each do |id|
      if id.present?
        friends << Friend.find(id)
      end
    end
  end

end
