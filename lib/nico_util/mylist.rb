# coding: utf-8

require 'open-uri'
require 'rexml/document'
require 'lambda_driver'

require 'nico_util/attr_setter'
require 'nico_util/hashable'

module NicoUtil
  class Mylist
    include NicoUtil::AttrSetter
    include NicoUtil::Hashable

    URL = /(http:\/\/www\.nicovideo\.jp\/mylist\/)?(\d+)(\?rss=2\.0)?/
    def initialize(group_id)
      builder = method(:build_url) >> method(:open) >> REXML::Document._.new >> (get_elements & "/rss/channel") >> :first
#      doc =
        if URL =~ group_id
          builder < $2
        else
          raise "not mylist url or unexist mylist"
        end
    end

    def to_h
    end

    private
    def build_url(mylist_id)
      "http://www.nicovideo.jp/mylist/#{mylist_id}?rss=2.0"
    end
  end
end
