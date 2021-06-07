#coding: utf-8
#添加内部中转运单功能
class AddInnerTransitBillFunction < ActiveRecord::Migration
  def up
    #内部中转业务
    group_name = "内部中转业务"
    #################################运单录入################################################
    subject_title = "内部中转运单录入"
    subject = "InnerTransitBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'can?(:create,InnerTransitBill) ? new_inner_transit_bill_path : inner_transit_bills_path("search[from_org_id_in]" => current_user.current_ability_org_ids,"search[completed_eq]" => 0,"search[bill_date_eq]" => Date.today,:sort => "carrying_bills.bill_date desc,goods_no",:direction => "asc")',
      :function => {
        :create => {:title => "新建"},
        :update_all =>{:title =>"修改",:conditions =>"{:state => ['loaded','billed'],:from_org_id => user.current_ability_org_ids}"},
        :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed'],:from_org_id => user.current_ability_org_ids}"},
        :print => {:title => "票据打印",:conditions =>"{:state => 'billed'}"},
        :invalidate => {:title => "票据作废",:conditions =>"{:state => 'billed'}"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
