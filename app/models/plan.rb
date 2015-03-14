class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :friends, through: :invitations
  has_many :options, :dependent => :destroy
  has_many :places, through: :options

  validates :name, presence: true
  validates :time, presence: true
  validates :friends, length: { minimum: 1, message: "Please select atleast one friend"}
  validates :places, length: { in: 2..3, message: "Please select two to three places" }

  def add_friends(friend_ids)
    friend_ids.each do |id|
      if id.present?
        friends << Friend.find(id)
      end
    end
  end

  def add_places(place_ids)
    place_ids.each do |id|
      if id.present?
        places << Place.find(id)
      end
    end
  end

  def set_time(date_time)
    if date_time > DateTime.now
      self.time = date_time
    end
  end
end
