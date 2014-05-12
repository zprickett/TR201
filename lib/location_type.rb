require 'csv'

class LocationType

  def initialize
    create_lookup_hash
  end

  def lookup(location)
    @type[location]
  end

  def all
    @type
  end

  def create_lookup_hash
    @type = {}
    CSV.foreach('data/location_lookup.csv') do |c|
      @type[c[0]] = c[1]
    end
  end

end