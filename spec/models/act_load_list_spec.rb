# -*- encoding : utf-8 -*-
require 'spec_helper'

describe ActLoadList do
  it "应能正确生成act_load_list，并保存成功" do
    load_list = Factory(:load_list_with_bills)
    act_load_list = load_list.build_act_load_list
    act_load_list.save!
  end
end

