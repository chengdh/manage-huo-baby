# -*- encoding : utf-8 -*-
#coding: utf-8
class AddReturnGoodsRpt < ActiveRecord::Migration
  def self.up
    group_name = "查询统计"
    ##############################返程票据统计#############################################
    subject_title = "返程票据统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_with_created_at_carrying_bills_path(:rpt_type => "rpt_return_goods_sum",:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc")',
      :subject => subject,
      :function => {
      :simple_search_with_created_at =>{:title =>"返程票据统计"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def self.down
  end
end

