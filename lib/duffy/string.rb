# Monkey Patch String adding useful methods.
class String

  # Easier way to calculate the md5sum of a string.
  def md5
    Digest::MD5.hexdigest(self)
  end
  alias_method :md5sum, :md5

  # Makes a nice box around your string for console output etc.
  # See Array :to_box
  def to_box(safe: true)
    Array(self).to_box(safe: safe) unless self.empty?
  end

  def to_ssn
    ssn = "%09d" % self.to_numeric.to_i           # strips string of non zeros, and pads leading zeros
    ssn[0..2] + "-" + ssn[3..4] + "-" + ssn[5..8] # now it's like 123-45-6789
  end

  # Sanitize SSN.
  #
  # "123456789"   => "123456789"      # Good
  # "123-45-6789" => "123456789"      # Good
  # "000-12-3456" => nil              # Invalid Area
  # "666123456"   => nil              # Invalid Area
  # "derp"        => nil              # Bogus
  # "123456"      => nil              # Too short ( becomes 000123456: Invalid Area )
  # "999999999"   => nil              # Important.  Many HRS entries
  # "-"           => nil              # Important.  Many HRS entries
  #
  # http://www.ssa.gov/history/ssn/geocard.html
  # http://en.wikipedia.org/wiki/Social_Security_number
  # area:   001 to 665, 667 to 899
  # group:  01 to 99.
  # serial: 0001 to 9999
  def sanitize_ssn
    begin
      ssn = "%09d" % self.to_numeric.to_i
      raise "Too Long" if ssn.length > 9
      area, group, serial = ssn[0..2], ssn[3..4], ssn[5..8]
      raise "Area Range Invalid" unless ("001" .. "665").cover?(area) or ("667" .. "899").cover?(area)
      raise "Group Range Invalid" unless ("01" .. "99").cover?(group)
      raise "Serial Range Invalid" unless ("0001" .. "9999").cover?(serial)
    rescue
      return nil
    end
    ssn
  end

  def to_numeric
    self.to_s.gsub(/[^0-9]/, "")            # now it's a string with only 0-9
  end

  def to_alpha
    self.to_s.gsub(/[^a-zA-Z ]/, "").strip  # string with only a-z or A-Z or space, leading+trailing whitespace removed
  end

  def to_alpha_numeric
    self.to_s.gsub(/[^0-9a-zA-Z ]/, "").strip  # string with only a-z or A-Z or space, leading+trailing whitespace removed
  end


  def pretty_phone
    number = self.to_s.gsub(/[^0-9\+]/, "")
    return "(" + number[0..2] + ") " + number[3..5] + "-" + number[6..9] if number.length == 10
    return number[0..2] + "-" + number[3..6] if number.length == 7
    number
  end

  # Parse a git username into a friendly name
  # Expects committers to be a hash in this format:  { jpd" => "Jacob", /ers|Eric/ => "Eric" }
  # All String keys are converted to Regex, explicit Regex is fine too.
  def pretty_committer
    Hash(Duffy.configuration.committers).map{|k,v| v if Regexp.new(k) =~ self}.compact.first or self
  end

  def space2nbsp
    # turns >= double space to double nbsp
    string = (self.nil?)? "" : self.to_s.gsub(/ {2,}/, "&nbsp;&nbsp;")
    defined?(html_safe) ? string.html_safe : string
  end

  # Replace the various combinations of newline characters with HTML <br> tags.
  def nl2br
    string = (self.nil?)? "" : self.to_s.gsub(/(\r\n)|(\n\r)|\n|\v/, "<br>")
    defined?(html_safe) ? string.html_safe : string
  end


  def gender_human
    case (self.to_s.upcase)
      when "M" then "Male"
      when "F" then "Female"
      when "O" then "Other"
      else ""
    end
  end


  # Smarter Titlecase function.
  # Examples:
  # "foo"                     => "Foo"
  # "IMPORTANT STUFF"         => "Important Stuff"
  # "123 main st."            => "123 Main St."
  # "a tale of two cities"    => "A Tale of Two Cities"
  def smart_titlecase
    small_re = %w( is a an and as at but by en for if in of on or the to v[.]? via vs[.]? ).join('|')

    # Original Perl version by: John Gruber        (daringfireball.net) 2008-05-10
    # Adapted to Ruby by:       Marshall Elfstrand (vengefulcow.com/    2008-05-21
    # Improved and customized:  Jacob Duffy        (duffy.jp)           2011-01-25
    # License:                  http://www.opensource.org/licenses/mit-license.php

    # if source is all uppercase, use all lowercase instead.  -- jpd
    string = (self.upcase == self)? self.downcase : self

    result = ""
    string.gsub('_', ' ').split(/( [:.;?!][ ] | (?:[ ]|^)[""] )/x).each do |s|
      s.gsub!(/ \b( [[:alpha:]] [[:lower:].'']* )\b /x) do |w|
        # Skip words with inresult dots, e.g. "del.icio.us" or "example.com"
        (w =~ / [[:alpha:]] [.] [[:alpha:]] /x) ? w : w.capitalize
      end

      # Lowercase our list of small words:
      s.gsub!(/\b(#{small_re})\b/io) { |w| w.downcase }

      # If the first word in the title is a small word, then capitalize it:
      s.gsub!(/\A([[:punct:]]*)(#{small_re})\b/io) { |w| $1 + $2.capitalize }

      # If the last word in the title is a small word, then capitalize it:
      s.gsub!(/\b(#{small_re})([[:punct:]]*)\Z/io) { |w| $1.capitalize + $2 }

      # Append current substring to output
      result += s
    end #each

    # Special Cases:
    upcase_re = (Array(Duffy.configuration.upcase_custom) + Array(Duffy.configuration.upcase_default)).uniq.join("|")

    # Names with apostrophes; O'Brian, De'Wayne. 3+ Skips "I've" "Haven't" etc.
    result.gsub!(/([A-Z][a-z]*)'([a-z]{3,})/) { "#{$1}'#{$2.capitalize}" }

    result.gsub!(/ V(s?)\. /, ' v\1. ') # "v." and "vs."

    result.gsub!(/([''])S\b/, '\1s') # 'S (otherwise you get "the SEC'S decision")

    result.gsub!(/\b(#{upcase_re})\b/i) { |w| w.upcase } unless upcase_re.blank?

    # Squash repeated whitespace characters
    result.gsub!(/\s+/, ' ')

    # Strip leading / tailing whitespace and return
    result.strip
  end
end
