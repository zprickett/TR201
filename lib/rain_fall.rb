require 'csv' unless defined?(CSV)

class RainFall
  attr_reader :rainfall
  def initialize
    create_hash
  end

  def create_hash
    @rainfall = {}
    CSV.foreach('data/rainhistory.csv') do |day|
      @rainfall[day[0]] = day[1]
    end
    @rainfall.to_json
  end

  def mm(date)
    @rainfall[date]
  end

  def as_json
    @rainfall.to_json
  end
end