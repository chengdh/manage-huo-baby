#coding: utf-8
#始发地收货统计功能修改
class ChangeRptToMeFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('始发地收货统计')
    default_action = 'carrying_bills_path(:rpt_type => "rpt_to_me","search[type_in]" => bill_types,"search[to_org_id_eq]" => current_user.default_org.id,"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day,:sort => "carrying_bills.bill_date desc,carrying_bills.goods_no",:direction => "asc" )'
    sf.update_attributes(:default_action => default_action) if sf
    ########################################################################
   
    sf = SystemFunction.find_by_subject_title('代收货款收入/支出统计')
    default_action = 'sum_goods_fee_inout_carrying_bills_path("search[type_in]" => bill_types)'
    sf.update_attributes(:default_action => default_action) if sf
  end

  def down
  end
end
