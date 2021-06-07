#coding: utf-8
class AddOutterTransitCashPayInfoFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-客户提款(现金)"
    subject = "OutterTransitCashPayInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,

      :default_action => 'can?(:create,OutterTransitCashPayInfo) ? new_outter_transit_cash_pay_info_path : outter_transit_cash_pay_infos_path',
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
