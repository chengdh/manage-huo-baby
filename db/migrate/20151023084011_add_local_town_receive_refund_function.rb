#coding: utf-8
#同城快运-返款清单确认
class AddLocalTownReceiveRefundFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-收款清单"
    subject = "LocalTownRefund"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:read_arrive,LocalTownRefund)? receive_local_town_refunds_path("search[state_eq]" => "refunded") : receive_local_town_refunds_path("search[state_eq]" => "refunded_confirmed")',
      :subject => subject,
      :function => {
        :read_arrive =>{:title => "查看",:conditions =>"{:state =>['refunded_confirmed','refunded'] ,:to_org_id => user.current_ability_org_ids}"} ,
        :read_confirmed =>{:title => "查看已确认收款单"},
        :refound_confirm => {:title => "收款确认",:conditions =>"{:state => 'refunded',:to_org_id => user.current_ability_org_ids}"},
        :export => {:title => "导出"}
      }

    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
