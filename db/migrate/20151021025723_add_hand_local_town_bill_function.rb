#coding: utf-8
class AddHandLocalTownBillFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    #################################运单录入################################################
    subject_title = "同城-手工运单录入"
    subject = "HandLocalTownBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'can?(:create,HandLocalTownBill) ? new_hand_local_town_bill_path : hand_local_town_bills_path("search[from_org_id_in]" => current_user.current_ability_org_ids,"search[completed_eq]" => 0,"search[bill_date_eq]" => Date.today,:sort => "carrying_bills.bill_date desc,goods_no",:direction => "asc")',
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
