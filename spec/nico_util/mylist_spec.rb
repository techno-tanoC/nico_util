# coding: utf-8

require 'spec_helper'
require 'pp'

ok_xml = open("spec/files/mylist.xml").read

describe NicoUtil::Mylist do
  context "when valid xml" do
    subject(:mylist) { NicoUtil::Mylist.new(ok_xml) }

    describe '#build_url' do
    end

    describe "#to_h" do
      it "have 18 items" do
        expect(mylist.to_h[:items]).to have(18).items
      end
    end
  end
end
