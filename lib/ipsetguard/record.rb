module Ipsetguard
  class Record
    attr_accessor :ip_cidr, :description
    def initialize
      @ip_cidr = nil
      @description = nil
    end
  end
end