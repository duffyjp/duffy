module Duffy

  # Depending on your hardware, you may want to make decisions in your code.
  # I use this to figure out how many processes I can launch in parallel.

  # This is linux specific (for now) and will return 1 for everything on other systems.

  class System
    class << self

      # How many Physical CPUs do you have.
      # Linux:  Detected by counting unique physical IDs
      # Mac:    hw.packages
      def cpus
        case RUBY_PLATFORM
          when /linux/  then File.read('/proc/cpuinfo').scan(/^physical id.*/).uniq.count rescue 1
          when /darwin/ then `sysctl -n hw.packages`.to_i rescue 1
          else 1
        end
      end

      # How many actual CPU cores do we have not including Hyperthreading
      # Linux:  "cpu cores" in cpuinfo is on a per physical processor basis, so we multiply by the number of CPUs
      # Mac:    hw.physicalcpu
      def cores
        case RUBY_PLATFORM
          when /linux/  then (File.read('/proc/cpuinfo').scan(/^cpu cores.*/).first.scan(/\d+$/).first.to_i rescue 1) * cpus
          when /darwin/ then `sysctl -n hw.physicalcpu`.to_i rescue 1
          else 1
        end
      end

      # How many threads does the system have.
      def threads
        case RUBY_PLATFORM
          when /linux/  then File.read('/proc/cpuinfo').scan(/^processor\s*:/).size rescue 1
          when /darwin/ then `sysctl -n hw.ncpu`.to_i rescue 1
          else 1
        end
      end

    end
  end
end
