# coding: utf-8
 
require 'time'
require 'open-uri'
require 'rexml/document'
require 'lambda_driver'

module NicoUtil
  class ThumbInfo
    THUMB = "http://ext.nicovideo.jp/api/getthumbinfo/"
    ID_REGEX = /^((sm|nm)(\d+))$/

    def initialize(str)
      build = REXML::Document._.new >> method(:validate) >> (:get_elements & 'nicovideo_thumb_response/thumb') >> :first

      @doc =
        if str =~ ID_REGEX
          THUMB._.+ >> method(:open) >> build < str
        elsif str.kind_of?(String)
          build < str
        else
          raise "invalid source"
        end
    end

    [
      :video_id, :title, :description, :thumbnail_url,
      :length, :movie_type, :size_high, :size_low,
      :last_res_body, :watch_url, :thumb_type, :embeddable,
      :no_live_play
    ].each do |name|
      define_method(name) {
        method(:get_text_by_symbol) < name
      }
    end

    [
      :view_counter, :comment_num, :mylist_counter
    ].each do |name|
      define_method(name) {
        method(:get_text_by_symbol) >> :to_i < name
      }
    end

    def first_retrieve
      method(:get_text) >> DateTime._.parse < "first_retrieve"
    end
    def tags
      @doc.get_elements('tags[@domain="jp"]/tag').map(&:text)
    end
 
    def to_h
      {
        video_id: video_id,
        title: title,
        description: description,
        thumbnail_url: thumbnail_url,
        first_retrieve: first_retrieve,
        length: length,
        movie_type: movie_type,
        size_high: size_high,
        size_low: size_low,
        view_counter: view_counter,
        comment_num: comment_num,
        mylist_counter: mylist_counter,
        last_res_body: last_res_body,
        watch_url: watch_url,
        thumb_type: thumb_type,
        embeddable: embeddable,
        no_live_play: no_live_play,
        tags: tags
      }
    end

    private
    def validate(doc)
      if doc.root.attribute('status').value == "ok"
        doc
      else
        raise doc.get_text("nicovideo_thumb_response/error/description")
      end
    end

    def get_text(tag)
      @doc._.text < tag
    end

    def get_text_by_symbol(sym)
      :to_s >> method(:get_text) < sym
    end
  end
end
