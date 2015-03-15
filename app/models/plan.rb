class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, :dependent => :destroy
  has_many :friends, through: :invitations
  has_many :options, :dependent => :destroy
  has_many :places, through: :options

  validates :name, presence: true
  validates :time, presence: true
  validates :friends, length: { minimum: 1, message: "Please select atleast one friend"}
  validates :options, length: { in: 2..3, message: "Please select two to three venues" }

  def add_friends(friend_ids)
    friend_ids.each do |id|
      if id.present?
        friends << Friend.find(id)
      end
    end
  end

  def add_venues(venue_ids)
    venue_ids.each do |id|
      if id.present?
        option = Option.new
        option.venue_id = id
        options << option
      end
    end
  end

  def add_time(date_time)
    if date_time > DateTime.now
      self.time = date_time
    end
  end

  def venues
    options.map { |option| option.venue }
  end
end
