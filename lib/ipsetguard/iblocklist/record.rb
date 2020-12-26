require_relative '../utils.rb'

module Ipsetguard
  module Iblocklist
    class Record
      include Ipsetguard::Utils

      def initialize(min, max, desc)
        @min = min
        @max = max
        @desc = desc
      end

      def to_ipset
        return ip_range_to_cidr(@min, @max)
      end
    end
  end
end
