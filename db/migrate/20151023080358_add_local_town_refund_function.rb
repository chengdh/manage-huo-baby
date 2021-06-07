#coding: utf-8
#添加同城快运-返款清单功能
class AddLocalTownRefundFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-返款清单"
    subject = "LocalTownRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,LocalTownRefund) ? new_local_town_refund_path : local_town_refunds_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
