#coding: utf-8
class AddInnerTransitDeliverInfoFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "客户提货"
    subject = "InnerTransitDeliverInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'can?(:create,InnerTransitDeliverInfo) ? new_inner_transit_deliver_info_path : inner_transit_deliver_infos_path',
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
        :create => {:title => "新建"},
        :batch_deliver => {:title => "批量提货"},
        :print_deliver => {:title => "打印提货"},
        :print => {:title => "仅打印提货单"},
        :export => {:title => "导出"}
      }

    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
