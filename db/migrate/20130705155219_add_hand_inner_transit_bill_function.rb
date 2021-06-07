#coding: utf-8
#手工内部中转运单
class AddHandInnerTransitBillFunction < ActiveRecord::Migration
  def up
    #内部中转业务
    group_name = "内部中转业务"
    #################################运单录入################################################
    subject_title = "内部中转运单(手工)"
    subject = "HandInnerTransitBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'can?(:create,HandInnerTransitBill) ? new_hand_inner_transit_bill_path : hand_inner_transit_bills_path("search[from_org_id_in]" => current_user.current_ability_org_ids,"search[completed_eq]" => 0,"search[bill_date_eq]" => Date.today,:sort => "carrying_bills.bill_date desc,goods_no",:direction => "asc")',
      :function => {
        :create => {:title => "新建"},
        :update_all =>{:title =>"修改",:conditions =>"{:state => ['loaded','billed'],:from_org_id => user.current_ability_org_ids}"},
        :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed'],:from_org_id => user.current_ability_org_ids}"},
        :invalidate => {:title => "票据作废",:conditions =>"{:state => 'billed'}"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
