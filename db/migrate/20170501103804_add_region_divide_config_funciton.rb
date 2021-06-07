#coding: utf-8
class AddRegionDivideConfigFunciton < ActiveRecord::Migration
  def up
    group_name = "内部中转-分成设置"
    subject_title = "分成比例设置"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => "RegionDivideConfig",
      :default_action => 'region_divide_configs_path()',
      :function => {
        :read => {:title => "查看"},
        :create => {:title => "新建"},
        :update => {:title => "修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
