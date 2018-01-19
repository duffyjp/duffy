class Date

  # Return the fiscal year for a given date.
  # See config to set the start of your fiscal year.
  # Example: Date.new(2015,10,1).fiscal_year => 2016
  def fiscal_year
    (self < Date.new(year, Duffy.configuration.fiscal_month, Duffy.configuration.fiscal_day)) ? year : year + 1
  end

  # Like beginning_of_year, but for Fiscal Years.
  # Date.new(2015,10,1).beginning_of_fiscal_year => 2015-07-01
  def beginning_of_fiscal_year
    Date.new(fiscal_year - 1, Duffy.configuration.fiscal_month, Duffy.configuration.fiscal_day)
  end
  alias_method :at_beginning_of_fiscal_year, :beginning_of_fiscal_year

  # Like end_of_year, but for Fiscal Years
  # Date.new(2015,10,1).end_of_fiscal_year => 2016-06-30
  def end_of_fiscal_year
    Date.new(fiscal_year, Duffy.configuration.fiscal_month, Duffy.configuration.fiscal_day).prev_day
  end
  alias_method :at_end_of_fiscal_year, :end_of_fiscal_year
end

class NilClass
  def to_date
    self
  end
end
