# coding: utf-8

require 'spec_helper'

thumb_xml = open("spec/files/thumb.xml").read

describe NicoUtil::ThumbInfo do
  context "when valid xml" do
    subject(:ok_thumb) { NicoUtil::ThumbInfo.new(thumb_xml) }

    describe "#initialize" do
      it 'should not raise error' do
        expect { ok_thumb }.not_to raise_error
      end
    end

    describe "#title" do
      it 'should get title' do
        ans = "【ごちうさ】【アニリミ】【HAPPY HARDCORE】Daydream cafe (KURO-HACO Remix)"
        expect(ok_thumb.title).to eq ans
      end
    end

    describe "#tags" do
      it 'should get tags' do
        ans = ["音楽", "ご注文はうさぎですか？", "Daydream_cafe", "アングラアニソンRemixリンク", "もっとご注文されるべき", "エンターテイメント", "アニメ"]
        expect(ok_thumb.tags).to match_array ans
      end
    end

    describe '#view_counter' do
      it 'should get view_counter' do
      end
    end

    describe '#to_h' do
      it 'should get tags' do
      end
    end
  end

  context "when invalid xml" do
    let(:ng_thumb) { NicoUtil::ThumbInfo.new("piyopiyo") }

    it 'should raise error' do
      expect { ng_thumb }.to raise_error
    end
  end
end

