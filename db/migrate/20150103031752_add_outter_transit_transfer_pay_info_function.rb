#coding: utf-8
class AddOutterTransitTransferPayInfoFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-客户提款(转账)"
    subject = "OutterTransitTransferPayInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,

      :default_action => 'can?(:create,OutterTransitTransferPayInfo) ? new_outter_transit_transfer_pay_info_path : outter_transit_transfer_pay_infos_path',
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :batch_pay =>{:title => "批量提款"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
