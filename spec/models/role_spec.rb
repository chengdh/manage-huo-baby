# -*- encoding : utf-8 -*-
#coding: utf-8
require 'spec_helper'

describe Role do
  it "应能够正确保存 role 角色信息" do
    role = Role.new_with_default(:name => 'role')
    role.save!
  end
end

