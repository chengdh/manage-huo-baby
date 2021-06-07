# -*- encoding : utf-8 -*-
#coding: utf-8
class ChangeShortFeeInfoDefaultAction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title("短途运费管理")
    sf.update_attributes(:default_action => "short_fee_infos_path('search[state_eq]' => 'draft')") if sf
  end

  def self.down
  end
end

