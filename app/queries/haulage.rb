class Haulage < Query
  def initialize
    @builder = cycles_table
      .project(cycles_table['Quantity'].sum.as('Quantity'))
      .project(cycles_table['Quantity'].average.as('AverageQuantity'))
      .project(cycles_table['Duration'].sum.as('Duration'))
      .project(Arel::Nodes::Addition.new(cycles_table['DurationQueueing'], cycles_table['DurationQueueAtDump']).sum.as('DurationQueueing'))
      .project(cycles_table['DurationTravelEmpty'].sum.as('DurationTravelEmpty'))
      .project(cycles_table['DurationLoading'].sum.as('DurationLoading'))
      .project(cycles_table['DurationTravelLoaded'].sum.as('DurationTravelLoaded'))
      .project(Arel::Nodes::Division.new(cycles_table['Quantity'], cycles_table['Duration']).sum.as('HaulagePerDuration'))
      .where(cycles_table['Duration'].gt(0))
      .where(cycles_table['Duration'].lt(60*60*24))
  end

  def by_day
    builder
      .project(Arel.sql('CAST([CYCLES].[EventDateTime] As Date)').as('Day'))
      .group('CAST([CYCLES].[EventDateTime] As Date)')
      .order('CAST([CYCLES].[EventDateTime] As Date)')
    self
  end

  def by_month
    builder
      .project(Arel.sql('MONTH([CYCLES].[EventDateTime])').as('Month'))
      .group('MONTH([CYCLES].[EventDateTime])')
      .order('MONTH([CYCLES].[EventDateTime])')
    self
  end

  def by_year
    builder
      .project(Arel.sql('YEAR([CYCLES].[EventDateTime])').as('Year'))
      .group('YEAR([CYCLES].[EventDateTime])')
      .order('YEAR([CYCLES].[EventDateTime])')
    self
  end
  
  def by_location(location=nil)
    builder
      .project(Arel.sql('LEFT([CYCLES].[Location], 3)').as('Location'))
      unless location.nil?
        builder.where(cycles_table['Location'].matches(location+'%'))
      else
        builder.where(cycles_table['Location'].matches('BEL%')
          .or(cycles_table['Location'].matches('ATH%'))
          .or(cycles_table['Location'].matches('HAM%'))
          .or(cycles_table['Location'].matches('CAV%'))
          .or(cycles_table['Location'].matches('ARG%'))
          .or(cycles_table['Location'].matches('MCB%'))
          .or(cycles_table['Location'].matches('PDY%'))
          .or(cycles_table['Location'].matches('MAR%'))
        )
      end
      .group('LEFT([CYCLES].[Location], 3)')
      .order('LEFT([CYCLES].[Location], 3)')
    self
  end
  
  def by_truck(truck=nil)
    builder
      .project(cycles_table['Truck'])
      .where(cycles_table['Quantity'].gt(0))
      .where(cycles_table['Truck'].matches('TR%'))
      .group(cycles_table['Truck'])
      .order(cycles_table['Truck'])
    unless truck.nil?
      builder.where(cycles_table['Truck'].eq(truck))
    end
    self
  end

  def with_location_type
    l = LocationType.new
    query =
        <<EOF
SELECT Location,
       SUM(Quantity) as Quantity


FROM HCK_PITRAMReporting.dbo.CYCLES
  WHERE CYCLES.EventDateTime > '2014-03-01'
GROUP BY Location, MONTH(CYCLES.EventDateTime)
EOF
    result = ActiveRecord::Base.connection.select_all(query)
    result.each do |r|
      r['location_type'] = l.lookup(r['Location'])
    end
    result

    summary = Hash.new {|hash, key| hash[key] = 0}
    result.each do |r|
      summary[r['location_type']] += r['Quantity'] || 0
    end
    summary
  end

  def run
    ActiveRecord::Base.connection.select_all(to_sql)
  end

  def cycles_table
    @cycles_table ||= Arel::Table.new('CYCLES')
  end
end
