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

    def video_id
      get_text 'video_id'
    end
    def title
      get_text 'title'
    end
    def description
      get_text 'description'
    end
    def thumbnail_url
      get_text 'thumbnail_url'
    end
    def first_retrieve
      method(:get_text) >> DateTime._.parse < "first_retrieve"
    end
    def length
      get_text 'length'
    end
    def movie_type
      get_text 'movie_type'
    end
    def size_high
      get_text 'size_high'
    end
    def size_low
      get_text 'size_low'
    end
    def view_counter
      get_text('view_counter').to_i
    end
    def comment_num
      get_text('comment_num').to_i
    end
    def mylist_counter
      get_text('mylist_counter').to_i
    end
    def last_res_body
      get_text 'last_res_body'
    end
    def watch_url
      get_text 'watch_url'
    end
    def thumb_type
      get_text 'thumb_type'
    end
    def embeddable
      get_text 'embeddable'
    end
    def no_live_play
      get_text 'no_live_play'
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
      if doc.root.attribute('status') == REXML::Attribute.new("status", "ok")
        doc
      else
        raise doc.get_text("nicovideo_thumb_response/error/description")
      end
    end

    def get_text(tag)
      @doc.get_text(tag)
    end
  end
end
