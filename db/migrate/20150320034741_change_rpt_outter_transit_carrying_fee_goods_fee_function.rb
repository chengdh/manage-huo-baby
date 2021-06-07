#coding: utf-8
#修改外部中转运费/货款统计表
class ChangeRptOutterTransitCarryingFeeGoodsFeeFunction < ActiveRecord::Migration
  def up
    ############################################################################################
    group_name = "外部中转业务"
    ##############################运费/货款统计#################################################
    subject_title = "外部中转-运费/货款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    default_action = 'simple_search_carrying_bills_path(:rpt_type => "rpt_outter_transit_carrying_fee_goods_fee",'+
      ':bill_types => ["TransitBill","HandTransitBill","OutterTransitReturnBill"],'+
      ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
      ':direction => "asc",:show_bill_no_eq => 1,'+
      ':show_fields => ".carrying_fee_total,.insured_fee,.transit_company,.transit_bill_no,.transit_carrying_fee,.transit_hand_fee,.agent_carrying_fee,.th_amount")'

    sf.update_attributes(:default_action => default_action) if sf
  end

  def down
  end
end
