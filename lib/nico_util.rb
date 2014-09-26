# coding: utf-8

require "nico_util/version"
Dir["#{File.dirname(__FILE__)}/nico_util/*.rb"].sort.each do |path|
  require "nico_util/#{File.basename(path, '.rb')}"
end

module NicoUtil
  module Nico
    REGEX = /(http:\/\/www\.nicovideo\.jp\/watch\/)?((sm|nm)(\d+))/
    def extract_id(url)
      if url =~ REGEX then $2 else raise "invalid url" end
    end

    def constract(str)
      url = "http://www.nicovideo.jp/watch/"
      if str =~ REGEX then url + $2 else raise "invalid str" end
    end
  end

  extend Nico
end
