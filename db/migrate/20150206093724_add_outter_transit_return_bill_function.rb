#coding: utf-8
#添加外部中转-退货相关功能
class AddOutterTransitReturnBillFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-退货单管理"
    subject = "OutterTransitReturnBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,OutterTransitReturnBill) ? before_new_outter_transit_return_bills_path : outter_transit_return_bills_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
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
