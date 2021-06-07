#coding: utf-8
#修改返程票据统计default_action
class ChangeReturnRptFunction < ActiveRecord::Migration
  def up
    subject_title = "返程票据统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_attributes(:default_action => 'simple_search_with_created_at_carrying_bills_path(:rpt_type => "rpt_return_goods_sum",:show_fields => ".carrying_fee_total,.insured_fee",:sort => "carrying_bills.bill_date asc,carrying_bills.goods_no",:direction => "asc")') if sf
  end

  def down
  end
end
