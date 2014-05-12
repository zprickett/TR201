module CyclesHelper
  def seconds_since_midnight_to_time(seconds)
    Time.parse('0:00', Time.now) + seconds.to_i
  end
end
