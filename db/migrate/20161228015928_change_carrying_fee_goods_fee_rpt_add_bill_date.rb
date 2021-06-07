#coding: utf-8
class ChangeCarryingFeeGoodsFeeRptAddBillDate < ActiveRecord::Migration
  def up
    ############################################################################################
    group_name = "内部中转业务"
    ##############################运费/货款统计#################################################
    subject_title = "内部中转-运费/货款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      default_action ='simple_search_carrying_bills_path(:rpt_type => "rpt_inner_transit_carrying_fee_goods_fee",'+
        ':bill_types => ["InnerTransitBill","HandInnerTransitBill","InnerTransitReturnBill"],'+
        '"search[bill_date_gte]" => Date.today,' +
        '"search[bill_date_lte]" => Date.today,' +
        ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
        ':direction => "asc",:show_bill_no_eq => 1,'+
        ':show_fields => ".carrying_fee_total,.insured_fee,.deliver_date,.pay_date")'
      sf.update_attributes(:default_action => default_action)
    end
    ############################################################################################
    group_name = "同城快运业务"
    ##############################运费/货款统计#################################################
    subject_title = "同城快运-运费/货款统计"

    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      default_action = 'simple_search_carrying_bills_path(:rpt_type => "rpt_local_town_carrying_fee_goods_fee",'+
        ':bill_types => ["LocalTownBill","HandLocalTownBill","LocalTownReturnBill"],'+
        '"search[bill_date_gte]" => Date.today,' +
        '"search[bill_date_lte]" => Date.today,' +
        ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
        ':direction => "asc",:show_bill_no_eq => 1,'+
        ':show_fields => ".carrying_fee_total,.insured_fee,.deliver_date,.pay_date")'
      sf.update_attributes(:default_action => default_action)
    end

    ############################################################################################
    group_name = "外部中转业务"
    ##############################运费/货款统计#################################################
    subject_title = "外部中转-运费/货款统计"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      default_action = 'simple_search_carrying_bills_path(:rpt_type => "rpt_outter_transit_carrying_fee_goods_fee",'+
        ':bill_types => ["TransitBill","HandTransitBill","OutterTransitReturnBill"],'+
        '"search[bill_date_gte]" => Date.today,' +
        '"search[bill_date_lte]" => Date.today,' +
        ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
        ':direction => "asc",:show_bill_no_eq => 1,'+
        ':show_fields => ".carrying_fee_total,.insured_fee,.transit_company,.transit_bill_no,.transit_carrying_fee,.transit_hand_fee,.agent_carrying_fee,.th_amount,.deliver_date,.pay_date")'

      sf.update_attributes(:default_action => default_action)
    end


    subject_title = "运费/货款统计"

    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      default_action = 'simple_search_carrying_bills_path(:rpt_type =>:carrying_fee_and_goods_fee_rpt,'+
      ':sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",'+
      '"search[bill_date_gte]" => Date.today,' +
      '"search[bill_date_lte]" => Date.today,' +
      ':direction => "asc",'+
      ':show_bill_no_eq => 1,'+
      ':show_fields => ".carrying_fee_total,.insured_fee,.print_counter,.deliver_date,.pay_date")'
      sf.update_attributes(:default_action => default_action)
    end

  end

  def down
  end
end
