class Date

  # Return the fiscal year for a given date.
  # See config to set the start of your fiscal year.
  # Example: Date.new(2015,10,1).fiscal_year => 2016
  def fiscal_year
    (self < Date.new(year, Duffy.configuration.fiscal_month, Duffy.configuration.fiscal_day)) ? year : year + 1
  end
end
