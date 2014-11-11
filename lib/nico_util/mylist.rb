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
      builder = method(:build_url) >> method(:open) >> :read >> REXML::Document._.new >> (:get_elements & "rss/channel") >> :first

      doc =
        if URL =~ group_id
          builder < $2
        else
          raise "not mylist url or unexist mylist"
        end

      [
        :title, :link, :description, :pubDate, :lastBuildDate
      ].each do |sym|
        attr_setter(sym, :to_s >> doc._.text < sym)
      end
      attr_setter(:creator, doc._.text < "dc:creator")

      attr_setter(:items) do
        doc.get_elements("item").map do |item|
          [:title, :link, :pubDate, :description].map {|sym|
            [sym, :to_s >> item._.text < sym]
          }.to_h
        end
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
