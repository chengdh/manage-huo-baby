#coding: utf-8
#添加内部中转－现金提款功能
class AddInnerTransitCashPayInfoFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "内部中转-客户提款(现金)"
    subject = "InnerTransitCashPayInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,InnerTransitCashPayInfo) ? new_inner_transit_cash_pay_info_path : inner_transit_cash_pay_infos_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :batch_pay =>{:title => "批量提款"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :print => {:title => "打印客户转账凭条",:conditions => "{:state => 'paid'}"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
