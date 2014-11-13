# coding utf-8

require 'spec_helper'

describe 'NicoUtil' do
  describe '#extract_id' do
    context 'ok' do
      it 'should extract id' do
        url = "http://www.nicovideo.jp/watch/sm12345678"
        expect(NicoUtil.extract_id(url)).to eq("sm12345678")

        url = "http://www.nicovideo.jp/watch/nm12345678"
        expect(NicoUtil.extract_id(url)).to eq("nm12345678")

        url = "sm12345678"
        expect(NicoUtil.extract_id(url)).to eq("sm12345678")

        url = "nm12345678"
        expect(NicoUtil.extract_id(url)).to eq("nm12345678")
    end
    end

    context 'invalid param' do
      it 'should raise error' do
        url = "gm1234"
        expect { NicoUtil.extract_id(url) }.to raise_error
      end
    end
  end

  describe '#constract' do
    context 'ok' do
      it 'should constract url' do
        url = "http://www.nicovideo.jp/watch/"
        expect(NicoUtil.constract("sm9")).to eq(url + "sm9")
      end
    end

    context 'gn' do
      it 'should raise error' do
        expect { NicoUtil.constract("piyo") }.to raise_error
      end
    end
  end
end

