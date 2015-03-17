class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :invitations, dependent: :destroy
  has_many :friends, through: :invitations
  has_many :options, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :time, presence: true
  validate  :future_time
  validates :friends, length: { minimum: 1, message: "Please select atleast one friend"}
  validates :options, length: { in: 2..3, message: "Please select two to three venues" }

  def init(user, friend_ids, venue_ids)
    self.user = user
    add_friends friend_ids if friend_ids
    add_venues venue_ids if venue_ids
    self
  end

  def future_time
    if !time.blank? && DateTime.now > time
      errors.add(:time, "Please select a future time")
    end
  end

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

  def ranked_options
    options.order(rank: :desc)
  end

  def venues
    ranked_options.map { |option| option.venue }
  end

  def selected_venue
    options.find_by(selected: true).venue
  end

  def select_option(option_id)
    option = options.find(option_id)
    option.selected = true
    option.save
  end
end
