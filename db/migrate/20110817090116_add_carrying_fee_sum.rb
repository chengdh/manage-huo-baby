# -*- encoding : utf-8 -*-
#coding: utf-8
class AddCarryingFeeSum < ActiveRecord::Migration
  def self.up
    ############################################################################################
    group_name = "查询统计"
    ##############################运费/货款统计#################################################
    subject_title = "运费/货款统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc",:show_bill_no_eq => 1 )',
      :subject => subject,
      :function => {
      :rpt_sum_fee =>{:title =>"运费/货款统计"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def self.down
  end
end

