require "ostruct"

class Venue
  def self.service
    @service ||= FoursquareService.new
  end

  def self.all
    service.venues.map { |venue| _build_object(venue) }
  end

  def self.find(id)
    _build_object(service.venue(id))
  end

  def self._build_object(data)
    OpenStruct.new(data)
  end
end
