class EquipmentController < ApplicationController
  
  def index
    # @equipment = ActiveRecord::Base.connection.select_all("SELECT EquipmentCode, Equipment_Model, Equipment_Model_Code, LEFT(c.Location, 3) AS Location, SUM(Quantity) AS total_quantity, SUM(DurationLoading) AS total_duration, SUM(Quantity)/SUM(DurationLoading) AS hauled_per_second_loading, SUM(Quantity)/SUM(DurationTravelLoaded) AS hauled_per_second_loaded FROM V_EQUIPMENT e JOIN CYCLES c ON e.EquipmentCode COLLATE DATABASE_DEFAULT = c.Truck COLLATE DATABASE_DEFAULT WHERE DurationLoading > 5 AND DurationTravelLoaded > 5 GROUP BY e.EquipmentCode, e.Equipment_Model, e.Equipment_Model_Code, LEFT(c.Location, 3) ORDER BY hauled_per_second_loaded DESC")
    @haulage_by_truck = Haulage.new.by_truck.run
  end
  
  def show
    id = params[:id]
    @haulage = Haulage.new
    @haulage_by_month = Haulage.new.by_year.by_month.by_truck(id).run
    @haulage_by_location = Haulage.new.by_location.by_truck(id).run
    
    # cycles = Arel::Table.new(:cycles)
    #     query = cycles.project(Arel.sql('*')).where(cycles['Truck'].eq(id))
    #     @cycles = ActiveRecord::Base.connection.select_all(query.to_sql)
  end
  
end
