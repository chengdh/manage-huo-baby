#coding: utf-8
#同城快运-分货清单
class AddLocalTownDistributionListFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-分货清单"
    subject = "LocalTownDistributionList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,LocalTownDistributionList) ? new_local_town_distribution_list_path : local_town_distribution_lists_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids}"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"}
      }

    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
