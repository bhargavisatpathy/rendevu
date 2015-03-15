class Option < ActiveRecord::Base
  belongs_to :place
  belongs_to :plan

  def venue
    Venue.find(venue_id)
  end
end
