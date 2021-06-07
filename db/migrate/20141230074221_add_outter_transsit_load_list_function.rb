#coding: utf-8
#添加外部中转货物运输清单功能
class AddOutterTranssitLoadListFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-货物运输清单"
    subject = "OutterTransitLoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'outter_transit_load_lists_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :ship => {:title => "发车",:conditions =>"{:from_org_id => user.current_ability_org_ids,:state => 'loaded'}"},
        :destroy => {:title => "删除",:conditions =>"{:from_org_id => user.current_ability_org_ids}"},
        :build_act_load_list => {:title => "生成实际装车清单"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
