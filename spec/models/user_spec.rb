# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe User do
  it "应能正确保存user对象信息" do
    Factory.build(:user).save!
  end

  it "应能够正确为新建用户设置默认值" do
    user = User.new_with_roles(:username => "new_username",:real_name => "test_user",:password => 'password',:password_confirmation => 'password')
    user.save!
  end

end

