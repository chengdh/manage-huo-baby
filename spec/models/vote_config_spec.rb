#coding: utf-8
require 'spec_helper'

describe VoteConfig do
  before :each do
    @vote_config = Factory(:vote_config)
  end
  it "应能够正确保存投票设置" do
    @vote_config.save!
  end
end
