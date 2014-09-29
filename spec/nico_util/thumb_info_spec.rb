# coding: utf-8

require 'spec_helper'

ok_xml = <<"XML"
<?xml version="1.0" encoding="UTF-8"?>
<nicovideo_thumb_response status="ok">
  <thumb>
    <video_id>sm9</video_id>
    <title>新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師</title>
    <description>レッツゴー！陰陽師（フルコーラスバージョン）</description>
    <thumbnail_url>http://tn-skr2.smilevideo.jp/smile?i=9</thumbnail_url>
    <first_retrieve>2007-03-06T00:33:00+09:00</first_retrieve>
    <length>5:19</length>
    <movie_type>flv</movie_type>
    <size_high>21138631</size_high>
    <size_low>17436492</size_low>
    <view_counter>14285779</view_counter>
    <comment_num>4228972</comment_num>
    <mylist_counter>151375</mylist_counter>
    <last_res_body>うううううううううう </last_res_body>
    <watch_url>http://www.nicovideo.jp/watch/sm9</watch_url>
    <thumb_type>video</thumb_type>
    <embeddable>1</embeddable>
    <no_live_play>0</no_live_play>
    <tags domain="jp">
      <tag lock="1">陰陽師</tag>
      <tag lock="1">レッツゴー！陰陽師</tag>
      <tag lock="1">公式</tag>
      <tag lock="1">音楽</tag>
      <tag lock="1">ゲーム</tag>
      <tag>sm9</tag>
      <tag>豪血寺一族</tag>
      <tag>最古の動画</tag>
      <tag>運営のお気に入り</tag>
      <tag>β時代の英雄</tag>
    </tags>
    <user_id>4</user_id>
    <user_nickname>運営長の中の人</user_nickname>
    <user_icon_url>http://usericon.nimg.jp/usericon/s/0/4.jpg?1410446718</user_icon_url>
  </thumb>
</nicovideo_thumb_response>
XML

fail_xml = <<XML

<?xml version="1.0" encoding="UTF-8"?>
<nicovideo_thumb_response status="fail">
  <error>
    <code>NOT_FOUND</code>
    <description>not found or invalid</description>
  </error>
</nicovideo_thumb_response>
XML

describe 'NicoUtil' do
  describe 'ThumbInfo' do
    describe "#initialize" do
      it 'should not raise error' do
        expect { NicoUtil::ThumbInfo.new(ok_xml) }.not_to raise_error
      end
      it 'should raise error' do
        expect { NicoUtil::ThumbInfo.new(fail_xml) }.to raise_error
      end
    end

    describe "#title" do
      it 'should get title' do
        ans = "新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師"
        expect(NicoUtil::ThumbInfo.new(ok_xml).title).to eq(ans)
      end
    end

    describe '#view_counter' do
      it 'should get view_counter' do
      end
    end

    describe "#tags" do
      it 'should get tags' do
        ans = ["陰陽師", "レッツゴー！陰陽師", "公式", "音楽", "ゲーム", "sm9", "豪血寺一族", "最古の動画", "運営のお気に入り", "β時代の英雄"]
        expect(NicoUtil::ThumbInfo.new(ok_xml).tags).to eq(ans)
      end
    end

    describe '#to_h' do
      it 'should get tags' do
        p NicoUtil::ThumbInfo.new(ok_xml).to_h
      end
    end
  end
end

