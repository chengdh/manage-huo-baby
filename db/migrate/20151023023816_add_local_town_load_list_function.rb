#coding: utf-8
#添加同城配送-运输清单功能
class AddLocalTownLoadListFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-货物运输清单"
    subject = "LocalTownLoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'local_town_load_lists_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :ship => {:title => "发车",:conditions =>"{:from_org_id => user.current_ability_org_ids,:state => 'loaded'}"},
        :destroy => {:title => "删除",:conditions =>"{:from_org_id => user.current_ability_org_ids}"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end


  def down
  end
end
