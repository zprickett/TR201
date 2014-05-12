class Duration < Query
  def initialize
    @builder = cycles_table.project(cycles_table['Duration'].sum.as('Quantity'))
  end

  def by_month
    builder
      .project(Arel.sql('MONTH([CYCLES].[EventDateTime])').as('Month'))
      .group('MONTH([CYCLES].[EventDateTime])')
    self
  end

  def by_year
    builder
      .project(Arel.sql('YEAR([CYCLES].[EventDateTime])').as('Year'))
      .group('YEAR([CYCLES].[EventDateTime])')
    self
  end

  def run
    ActiveRecord::Base.connection.select_all(to_sql)
  end

  def cycles_table
    @cycles_table ||= Arel::Table.new('CYCLES')
  end
end
