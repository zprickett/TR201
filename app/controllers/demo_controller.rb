class DemoController < ApplicationController
  def index
    @haulage_by_month = Haulage.new.by_year.by_month.run
    @haulage_by_month_by_location = Haulage.new.by_year.by_month.by_location.run
    @haulage = Haulage.new.run
    @haulage_by_tr201_by_month = Haulage.new.by_truck('TR201').by_year.by_month.run
    @movement_type = Haulage.new.with_location_type
  end
end
