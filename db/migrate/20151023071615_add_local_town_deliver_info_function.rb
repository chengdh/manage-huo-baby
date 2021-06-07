#coding: utf-8
#同城快运-客户提货
class AddLocalTownDeliverInfoFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-客户提货"
    subject = "LocalTownDeliverInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'can?(:create,LocalTownDeliverInfo) ? new_local_town_deliver_info_path : local_town_deliver_infos_path',
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
