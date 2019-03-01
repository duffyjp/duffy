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
end