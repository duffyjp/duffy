module Duffy
  VERSION = '0.3.5'
end

# History
# 0.3.5 - Fixed linux cores detection for very high core count CPUs.  Added virtualization detection on linux.
# 0.3.4 - pretty_phone now adds the dash for 7 digit phone numbers.
# 0.3.3 - Added beginning_of_fiscal_year and end_of_fiscal_year methods to Date
# 0.3.2 - Added mem_percentage as a convenience and safeguard against div/0 in user code.
# 0.3.1 - Fixed mem_available for old linux distros.
# 0.3.0 - Added system memory methods.  Removed deprecated icon methods.
# 0.2.7 - Deprecated "icon" and "excel_icon"
# 0.2.6 - Added cpu_percent to give the current total CPU usage percentage.
# 0.2.5 - Added beast_mode helper to render partials in parallel
# 0.2.4 - Added NilClass.to_date => nil
