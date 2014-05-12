class Query
  def to_sql
    builder.to_sql
  end

  def method_missing(method, *args)
    if builder.respond_to?(method)
      builder.send(method, args)
      return self
    else
      super
    end
  end

protected
  def builder
    @builder
  end

  def builder=(builder)
    @builder = builder
  end
end
