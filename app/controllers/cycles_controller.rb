class CyclesController < ApplicationController
  
  def index
    @haulage_by_location = Haulage.new.by_location.run
  end
  
end
