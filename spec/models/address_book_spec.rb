#coding: utf-8
require 'spec_helper'

describe AddressBook do
  before(:each) do
    @address_book = Factory.build(:address_book)
  end
  it "应能够成功保存通讯录信息" do 
    @address_book.save!
  end
  it "保存时,必须录入名称和联系方式" do
    attrs = @address_book.attributes.merge("name" => nil,"phone" => nil)
    address_book = AddressBook.new(attrs)
    address_book.should_not be_valid
  end
end
