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
          when /linux/  then File.read('/proc/cpuinfo').scan(/^physical id.*/).uniq.count
          when /darwin/ then `sysctl -n hw.packages`.to_i
          else 1
        end
      rescue
        1
      end

      # How many actual CPU cores do we have not including Hyperthreading
      # Linux:  "cpu cores" in cpuinfo is on a per physical processor basis, so we multiply by the number of CPUs
      # Mac:    hw.physicalcpu
      def cores
        case RUBY_PLATFORM
          when /linux/  then (File.read('/proc/cpuinfo').scan(/^cpu cores.*/).first.scan(/\d+$/).first.to_i rescue 1) * cpus
          when /darwin/ then `sysctl -n hw.physicalcpu`.to_i
          else 1
        end
      rescue
        1
      end

      # How many threads does the system have.
      def threads
        case RUBY_PLATFORM
          when /linux/  then File.read('/proc/cpuinfo').scan(/^processor\s*:/).size
          when /darwin/ then `sysctl -n hw.ncpu`.to_i
          else 1
        end
      rescue
        1
      end

      # What is a sane number of threads to use for data processing.
      # Only using physical cores is a waste, using all logical cores decreases performance.
      def sane_load
        (cores + threads) / 2
      end

      # The system's current CPU utilization.
      # Darwin: Get a list of all processes' CPU percentage and add them up.  Accurate to a couple percent vs. Activity Monitor.
      # Linux:  Read /proc/stat twice and take the difference to give cpu time used in that interval.
      def cpu_percent
        case RUBY_PLATFORM
          when /darwin/ then `ps -A -o %cpu`.lines.map(&:to_f).inject(:+) / threads
          when /linux/  then proc_diff
          else 0
        end
      rescue
        0
      end

      # Total system memory in Megabytes
      # Darwin: hw.memsize (bytes)
      # Linux:  Read /proc/meminfo
      def mem_total
        case RUBY_PLATFORM
          when /darwin/ then `sysctl -n hw.memsize`.to_i / 1024 / 1024
          when /linux/  then File.read("/proc/meminfo").lines.grep(/MemTotal/).first.split[1].to_i / 1024
          else 0
        end
      rescue
        0
      end

      # Memory available for use in Megabytes
      # Darwin: vm_stat (Pages Free + Pages Inactive)
      # Linux:  Read /proc/meminfo
      def mem_available
        case RUBY_PLATFORM
          when /darwin/ then `vm_stat`.lines.grep(/Pages free|Pages inactive/).map{|m| m.split.last.to_i}.inject(&:+) * 4 / 1024
          when /linux/  then (File.read("/proc/meminfo").lines.grep(/MemAvailable/).first.split[1].to_i / 1024)
          else 0
        end
      rescue
        0
      end

      # Memory used
      # Subtract mem_available from mem_total.
      # This ignores file cache etc that is not actually used by programs.
      def mem_used
        mem_total - mem_available
      end

      private

      # [CPU USE, CPU IDLE]
      def proc_stat
        cpu = File.open("/proc/stat", "r").read.lines.first
        [cpu.split[1 .. 3].map(&:to_i).inject(:+), cpu.split[1 .. 4].map(&:to_i).inject(:+)]
      end

      # Poll proc_stat twice and find the usage in that time.
      # Higher Sleep is more accurate, but obviously slower.
      def proc_diff
        s = proc_stat
        sleep 0.2
        f = proc_stat
        (f[0] - s[0]) * 100.0 / (f[1] - s[1])
      end

    end
  end
end
