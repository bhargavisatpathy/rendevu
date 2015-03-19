require 'ostruct'

class FoursquareService
  attr_reader :connection

  def initialize
    @connection ||= Faraday::Connection.new(:url => api_url,
                                            :params => params)
  end

  def venues
    response = connection.get do |req|
      req.url "venues/explore", search_options
    end
    groups = parse(response)['response']['groups']
    venues = []
    groups.each do |group|
      group['items'].each do |item|
        venues << venue(item['venue']['id'])
      end
    end
    venues
  end

  def venue(id)
    venue = parse(connection.get("venues/#{id}"))['response']['venue']
    _venue = { id: venue['id'], name: venue['name'], address: venue['location']['formattedAddress'][0..-2].join(' ') }
    if !venue['photos']['groups'].empty?
      _venue['photo'] = venue['photos']['groups'][0]['items'][0]
    end
    OpenStruct.new _venue
  end

  private

  def parse(response)
    JSON.parse(response.body)
  end

  def params
    {
      client_id: ENV['foursquare_key'],
      client_secret: ENV['foursquare_secret'],
      v: 20150314
    }
  end

  def search_options
    {
      near: "Denver, CO",
      radius: 250,
      section: "food",
      limit: 9,
      time: "any",
      day: "any",
      venuePhotos: 0
    }
  end

  def api_url
    "https://api.foursquare.com/v2"
  end

end
