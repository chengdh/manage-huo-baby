#coding: utf-8
#添加外部中转-运费/货款统计
class AddRptOutterTransitCarryingFeeGoodsFee < ActiveRecord::Migration
  def up
    ############################################################################################
    group_name = "外部中转业务"
    ##############################运费/货款统计#################################################
    subject_title = "外部中转-运费/货款统计"
    subject = "CarryingBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'simple_search_carrying_bills_path(:rpt_type => "rpt_outter_transit_carrying_fee_goods_fee",'+
      ':bill_types => ["TransitBill","HandTransitBill","OutterTransitReturnBill"],'+
      ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
      ':direction => "asc",:show_bill_no_eq => 1,'+
      ':show_fields => ".carrying_fee_total,.insured_fee")',
      :subject => subject,
      :function => {
        :rpt_outter_transit_carrying_fee_goods_fee =>{:title => subject_title}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
