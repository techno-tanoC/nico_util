# coding: utf-8

require 'spec_helper'

ok_xml = open("spec/files/ok.xml").read

describe 'NicoUtil' do
  describe 'Mylist' do
    subject { NicoUtil::Mylist.new(ok_xml) }

    describe '#build_url' do
    end

    describe '#build' do
    end
  end
end
