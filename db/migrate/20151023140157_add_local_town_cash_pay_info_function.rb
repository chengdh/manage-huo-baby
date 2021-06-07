#coding: utf-8
#同城快运-客户提款(现金)
class AddLocalTownCashPayInfoFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-客户提款(现金)"
    subject = "LocalTownCashPayInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,LocalTownCashPayInfo) ? new_local_town_cash_pay_info_path : loca_town_cash_pay_infos_path',
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
