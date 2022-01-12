class Array
  # Make a nice box around any number of string(able) items.
  # String.to_box is also available.
  # Truncates at 80 characters.
  #   puts ["test", :info].to_box
  #   +------+------+
  #   | test | info |
  #   +------+------+
  #
  def to_box(safe: true)
    return nil if self.empty?
    b = safe ? "+-++ | +++" : "╔─╦╗ ║ ╚╩╝"
    out  = (b[0] + self.map{ |x| b[1] * (x.to_s.gsub(/\e\[([;\d]+)?m/, '').length + 2) }.join(b[2]) + b[3])[0,80] + "\n"
    out << (b[5,2] + self.join(b[4,3]) + b[4,2])[0,80] + "\n"
    out << (b[7] + self.map{ |x| b[1] * (x.to_s.gsub(/\e\[([;\d]+)?m/, '').length + 2) }.join(b[8]) + b[9])[0,80]
  end



  # Create a markdown table from a 2D Array
  #
  # puts [["Car", "Boat", Date.today, 5],["Horse", "Car", nil, 0]].to_markdown
  # String | String | Date       | Integer
  # -------|--------|------------|---------
  # Car    | Boat   | 2022-01-12 | 5
  # Horse  | Car    |            | 0
  #
  def to_markdown
    raise "expected 2D array" unless self.first.is_a?(Array)

    # Find max widths of data/headers: eg => [10, 25, 18, 21, 6]
    widths = self.transpose.map{ |col| ([col.first.class.to_s.length] + col.map{ |i| i.to_s.length }).max }

    # Use the class of each cell in the first row for the table headers.
    out = self.first.map.with_index{|c,i| c.class.to_s.ljust(widths[i])}.join(" | ") + "\n"
    out << out.gsub(/[^|]/, "-") + "\n"

    # Left justify each cell
    self.each do |row|
      out << row.map(&:to_s).map.with_index{|c,i| c.ljust(widths[i])}.join(" | ") + "\n"
    end
    out

  rescue => e
    warn "Unable to generate table: #{e}"
    nil
  end

end