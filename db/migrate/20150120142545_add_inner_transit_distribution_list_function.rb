#coding: utf-8
#添加内部中转分货单
class AddInnerTransitDistributionListFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "分货清单管理"
    subject = "InnerTransitDistributionList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'can?(:create,InnerTransitDistributionList) ? new_inner_transit_distribution_list_path : inner_transit_distribution_lists_path',
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
