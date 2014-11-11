# coding: utf-8
 
require 'time'
require 'open-uri'
require 'rexml/document'
require 'lambda_driver'

require 'nico_util/validate'
require 'nico_util/attr_setter'
require 'nico_util/hashable'

module NicoUtil
  class ThumbInfo
    include NicoUtil::Validate
    include NicoUtil::AttrSetter
    include NicoUtil::Hashable

    THUMB = "http://ext.nicovideo.jp/api/getthumbinfo/"
    ID_REGEX = /^((sm|nm)(\d+))$/

    def initialize(str)
      build = REXML::Document._.new >> method(:validate_state) >> (:get_elements & 'nicovideo_thumb_response/thumb') >> :first

      doc =
        if str =~ ID_REGEX
          THUMB._.+ >> method(:open) >> build < str
        elsif str.kind_of?(String)
          build < str
        else
          raise "invalid source"
        end

      get_text = ->(tag) { doc._.text < tag }
      get_text_by_symbol = :to_s >> get_text

      [
        :video_id, :title, :description, :thumbnail_url,
        :length, :movie_type, :size_high, :size_low,
        :last_res_body, :watch_url, :thumb_type, :embeddable,
        :no_live_play
      ].each do |sym|
        attr_setter(sym, get_text_by_symbol < sym)
      end

      [ :view_counter, :comment_num, :mylist_counter ].each do |sym|
        attr_setter(sym, get_text_by_symbol >> :to_i < sym)
      end

      attr_setter(:first_retrieve, get_text >> DateTime._.parse < "first_retrieve")
      attr_setter(:tags, doc.get_elements('tags[@domain="jp"]/tag').map(&:text))
    end

    #undefined method `to_h' under ruby2.1
    def to_h
      to_hash_by_public_send([
        :video_id, :title, :description, :thumbnail_url,
        :first_retrieve, :length, :movie_type, :size_high,
        :size_low, :view_counter, :comment_num, :mylist_counter,
        :last_res_body, :watch_url, :thumb_type, :embeddable,
        :no_live_play, :tags
      ], [])
    end
  end
end
