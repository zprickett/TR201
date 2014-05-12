module DemoHelper
  def average_quantity(hauls)
    total = 0
    hauls.each_with_index do |haul, index|
      next if index+1 == hauls.count
      total += haul['Quantity']
    end
    total / (hauls.count-1)
  end
  
  def average_duration(hauls)
    total = 0
    hauls.each_with_index do |haul, index|
      next if index+1 == hauls.count
      total += haul['Duration']
    end
    total / (hauls.count-1)
  end
  
  def percentage_change(value1, value2)
    ((value1 - value2) / value2) * 100
  end
  
  def haulage_metric(haulage_by_month)
    percentage_change(haulage_by_month.last['Quantity'], average_quantity(haulage_by_month))
  end
  
  def cycle_metric(haulage_by_month)
    percentage_change(haulage_by_month.last['Duration'], average_duration(haulage_by_month))
  end
  
end
