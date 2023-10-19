require 'spec_helper'

describe String do

  describe "md5" do
    it "generates an md5sum of the given string" do
      expect("foobar".md5).to eq "3858f62230ac3c915f300c664312c63f"
    end
  end

  describe "nl2br" do
    it "converts linux newlines" do
      expect("This\nand\nthat.".nl2br).to eq "This<br>and<br>that."
    end
    it "converts windows newlines" do
      expect("This\r\nand\r\nthat.".nl2br).to eq "This<br>and<br>that."
    end
    it "converts backwards windows newlines" do
      expect("This\n\rand\n\rthat.".nl2br).to eq "This<br>and<br>that."
    end

    it "converts vertical tabs from dubious software newlines" do
      expect("This\vand\vthat.".nl2br).to eq "This<br>and<br>that."
    end

    it "slash R slash N slash N becomes <br><br>" do
      expect("This\r\n\nthat.".nl2br).to eq "This<br><br>that."
    end

    it "slash N slash R slash N becomes <br><br>" do
      expect("This\n\r\nthat.".nl2br).to eq "This<br><br>that."
    end

    it "slash N slash N slash R becomes <br><br>" do
      expect("This\n\n\rthat.".nl2br).to eq "This<br><br>that."
    end

    it "slash N slash N slash N becomes <br><br><br>" do
      expect("This\n\n\nthat.".nl2br).to eq "This<br><br><br>that."
    end
  end


  describe "pretty_phone" do
    it "formats an American phone number with Area Code" do
      expect("1234567890".pretty_phone).to eq "(123) 456-7890"
    end

    it "formats an American phone number without Area Code" do
      expect("4567890".pretty_phone).to eq "456-7890"
    end

    it "leaves longer strings alone" do
      expect("11234567890".pretty_phone).to eq "11234567890"
    end

    it "leaves shorter strings alone" do
      expect("1123".pretty_phone).to eq "1123"
    end
  end

  describe "space2nbsp" do

    it "leaves single space alone" do
      expect("1 1".space2nbsp).to eq "1 1"
    end

    it "turns double space to double nbsp" do
      expect("1  2".space2nbsp).to eq "1&nbsp;&nbsp;2"
    end

    it "turns triple space to double nbsp" do
      expect("1   3".space2nbsp).to eq "1&nbsp;&nbsp;3"
    end
  end

  describe "smart_titlecase" do
    {
      "123 Main St."            => "123 Main St.",            # Numbers are allowed
      "A Tale Of Two Cities"    => "A Tale of Two Cities",    # Articles are only capitalized if first
      "At mt. Kilimanjaro"      => "At Mt. Kilimanjaro",      # Small non-articles are capitalized
      "De'wayne"                => "De'Wayne",                # Names with apostrophes (longer first half)
      "Hyphenated-Lastname"     => "Hyphenated-Lastname",     # Hyphenated words retain hyphen and capitalize
      "I'm Here Ma'am"          => "I'm Here Ma'am",          # Contractions are treated as a single word
      "Miller (Smith)"          => "Miller (Smith)",          # Parentheses are allowed
      "O'brian"                 => "O'Brian",                 # Names with apostrophes (single character first half)
      "Sample"                  => "Sample",                  # Already Capitalized, all lower, all upper okay
      "Under_scores"            => "Under Scores",            # Underscores are treated as spaces

      "Double  Space"           => "Double Space",            # Clear duplicated whitespace
      "  Leading Space"         => "Leading Space",           # Remove leading whitespace
      "Trailing Space  "        => "Trailing Space",          # Remove trailing whitespace
    }.each do |before, after|

      # As typed above
      it "#{before.strip.ljust(22)} => #{after}" do
        expect(before.smart_titlecase).to eq after
      end

      # As all-lowercase
      it "#{before.strip.downcase.ljust(22)} => #{after}" do
        expect(before.downcase.smart_titlecase).to eq after
      end

      # As all-uppercase
      it "#{before.strip.upcase.ljust(22)} => #{after}" do
        expect(before.upcase.smart_titlecase).to eq after
      end
    end

    # CamelCase words will be preserved.
    {
      "DreamWorks"              => "DreamWorks",
      "McDonald's happy-meal"   => "McDonald's Happy-Meal",
    }.each do |before, after|

      # As typed above
      it "#{before.ljust(22)} => #{after}" do
        expect(before.smart_titlecase).to eq after
      end
    end

  end

  describe "to_alpha" do
    it "strips everything but a-z and A-Z" do
      expect("123abc$%^DEF".to_alpha).to eq "abcDEF"
    end
  end
  describe "to_alpha_numeric" do
    it "strips everything but a-z, A-Z and 0-9" do
      expect("123abc$%^DEF".to_alpha_numeric).to eq "123abcDEF"
    end
  end

  describe "to_box" do
    it "creates a safe box around a string" do
      expect("foobar".to_box).to eq "+--------+\n| foobar |\n+--------+"
    end

    it "creates a fancy box around a string" do
      expect("foobar".to_box(safe: false)).to eq "╔────────╗\n║ foobar ║\n╚────────╝"
    end

    it "empty string returns nil" do
      expect("".to_box).to eq nil
    end

  end

  describe "to_ssn" do
    it "maintains an already formatted SSN" do
      expect("123-45-6789".to_ssn).to eq("123-45-6789")
    end

    it "formats a ssn with leading zero properly" do
      expect("078051120".to_ssn).to eq("078-05-1120")
    end

    it "formats an unformatted SSN" do
      expect("123456789".to_ssn).to eq("123-45-6789")
    end

    it "adds leading zeros to 8 digit SSNs (yes, they exist)" do
      expect("12345678".to_ssn).to eq("012-34-5678")
    end

    it "should correctly add leading zeroes to short SSNs that start with 0" do
      expect("01".to_ssn).to eq("000-00-0001")
      expect("1".to_ssn).to eq("000-00-0001")
    end
  end

  describe "sanitize_ssn" do

    it "123456789   => 123456789" do
      expect("123456789".sanitize_ssn).to eq("123456789")
      # Good
    end

    it "123-45-6789 => 123456789" do
      expect("123-45-6789".sanitize_ssn).to eq("123456789")
      # Good
    end

    it "000-12-3456 => nil" do
      expect("000-12-3456".sanitize_ssn).to eq(nil)
      # Invalid Area
    end

    it "078051120   => 078051120 " do
      expect("078051120".sanitize_ssn).to eq("078051120")
    end

    it "666123456   => nil" do
      expect("666123456".sanitize_ssn).to eq(nil)
      # Invalid Area
    end

    it "derp        => nil" do
      expect("derp".sanitize_ssn).to eq(nil)
      # Bogus
    end

    it "123456      => nil" do
      expect("123456".sanitize_ssn).to eq(nil)
      # Too short ( becomes 000123456: Invalid Area )
    end

    it "999999999   => nil" do
      expect("999999999".sanitize_ssn).to eq(nil)
      # Important.  Many HRS entries
    end

    it "-           => nil" do
      expect("-".sanitize_ssn).to eq(nil)
      # Important.  Many HRS entries
    end
  end








end
