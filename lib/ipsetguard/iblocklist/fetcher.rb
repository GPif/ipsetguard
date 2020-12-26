require 'net/http'
require 'zlib'
require 'stringio'

require_relative './record.rb'

module Ipsetguard
  module Iblocklist
    class Fetcher
      attr_accessor :url, :records
      def initialize(url)
        @url = url
        @records = []
      end
  
      def fetch
        resp = self.class.get_with_redirect(@url)
        set = unzip(resp)
        set2record(set)
        self
      end
      
      def self.get_with_redirect(url)
        resp = Net::HTTP.get_response(URI(url))
        if resp.kind_of? Net::HTTPRedirection
          return get_with_redirect(resp.to_hash['location'][0])
        elsif resp.kind_of? Net::HTTPSuccess
          return resp
        else
          return false
        end
      end
  
      def unzip(resp)
        gz = Zlib::GzipReader.new(StringIO.new(resp.body.to_s))    
        uncompressed_string = gz.read
        arr = uncompressed_string.split("\n")
      end

      def set2record(set)
        set.each do |row|
          if row =~ /^(.+):(.+)-(.+)$/
            @records << Record.new($2, $3, $1)
          end
        end
      end
    end
  end
end