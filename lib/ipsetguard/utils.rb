module Ipsetguard
  module Utils
    #
    # convert ip range to CIDR notation
    #
    # @param [String] min min ip range
    # @param [String] max max ip range
    #
    # @return [String] ip with CIDR notation
    #
    def ip_range_to_cidr(min, max)
      ref_mask = IPAddr.new("255.255.255.255")
      diff = IPAddr.new(max).to_i ^ IPAddr.new(min).to_i
      cidr = 32 - (Math.log2(diff + 1))
      return "#{min}/#{cidr.to_i}"
    end
  end
end