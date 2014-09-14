# coding utf-8

require 'spec_helper'

describe 'NicoUtil' do
  describe '#extract_id' do
    it 'should go well' do
      url = "http://www.nicovideo.jp/watch/sm12345678"
      expect(NicoUtil.extract_id(url)).to eq("sm12345678")

      url = "http://www.nicovideo.jp/watch/nm12345678"
      expect(NicoUtil.extract_id(url)).to eq("nm12345678")

      url = "sm12345678"
      expect(NicoUtil.extract_id(url)).to eq("sm12345678")

      url = "nm12345678"
      expect(NicoUtil.extract_id(url)).to eq("nm12345678")
    end

    it 'should raise error' do
      url = "gm1234"
      expect { NicoUtil.extract_id(url) }.to raise_error
    end
  end
end

