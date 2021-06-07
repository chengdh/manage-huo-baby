#coding: utf-8
require 'spec_helper'

describe Notice do
  it "应能成功保存提醒信息" do
    notice = Factory.build(:notice)
    notice.notice_lines << Factory.build(:notice_line)
    notice.save!
  end
end
