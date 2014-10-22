# coding: utf-8

require 'spec_helper'

class AttrSetterSpec
  include NicoUtil::AttrSetter
end

describe 'AttrSetter' do
  describe '#arrt_setter' do
    let(:obj) { AttrSetterSpec.new }

    it 'should set by param' do
      obj.attr_setter(:piyo, "piyopiyo")
      expect(obj.piyo).to eq("piyopiyo")
    end

    it 'should set by block' do
      obj.attr_setter(:piyo) do
        "piyopiyo"
      end
      expect(obj.piyo).to eq("piyopiyo")
    end

    it 'should override by block' do
      obj.attr_setter(:piyo, "tyuntyun") do
        "piyopiyo"
      end
      expect(obj.piyo).to eq("piyopiyo")
    end
  end

  describe '#arr_setter' do
    let(:obj) { AttrSetterSpec.new }

    it 'should set by params' do
      obj.arr_setter([:piyo, :tyun]) do |sym|
        (sym == :piyo) ? "piyopiyo" : "tyuntyun"
      end
      expect(obj.piyo).to eq("piyopiyo")
      expect(obj.tyun).to eq("tyuntyun")
    end
  end
end
