module Duffy

  # Depending on your hardware, you may want to make decisions in your code.
  # I use this to figure out how many processes I can launch in parallel.

  # This is linux specific (for now) and will return 1 for everything on other systems.

  class System
    class << self

      # How many Physical CPUs do you have.
      # Detected by counting unique physical IDs
      def cpus
        File.read('/proc/cpuinfo').scan(/^physical id.*/).uniq.count rescue 1
      end

      # How many actual CPU cores do we have not including Hyperthreading
      # "cpu cores" in cpuinfo is on a per physical processor basis, so we multiply by the number of CPUs
      def cores
        (File.read('/proc/cpuinfo').scan(/^cpu cores.*/).first.scan(/\d+$/).first.to_i rescue 1) * cpus
      end

      # How many threads does the system have.
      def threads
        File.read('/proc/cpuinfo').scan(/^processor\s*:/).size rescue 1
      end

    end
  end
end