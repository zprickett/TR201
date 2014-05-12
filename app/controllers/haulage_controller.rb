class HaulageController < ApplicationController

  def index
      @locations = %w(ARG ATH BEL CAV HAM MAR MCB PDY)
      @haulage_by_month = Hash.new
      @locations.each do |loc|
        @haulage_by_month[loc] = Haulage.new.by_year.by_month.by_location(loc).run
      end 
      @haulage_by_location = Haulage.new.by_location.run
  end
  
  def pdy
  end
  
  def show
      @haulage_MCB = Haulage.new.by_day.by_location('MCB').run 
      @haulage_by_month_MCB = Haulage.new.by_year.by_location('PDY').run 
  end

end
