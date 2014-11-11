# coding: utf-8

require 'spec_helper'
require 'pp'

ok_xml = open("spec/files/ok.xml").read

describe 'NicoUtil' do
  describe 'Mylist' do
    subject { NicoUtil::Mylist.new(ok_xml) }

    it 'test' do
      pp NicoUtil::Mylist.new("45604545")
    end

    describe '#build_url' do
    end

    describe '#build' do
    end
  end
end
