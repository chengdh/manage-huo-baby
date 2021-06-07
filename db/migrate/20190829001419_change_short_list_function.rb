#coding: utf-8
#修改short_list function
class ChangeShortListFunction < ActiveRecord::Migration
  def up
    group_name = "短驳业务"
    subject_title = "短驳单"
    subject = "ShortList"

    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => "short_lists_path('search[from_org_id_in]' => current_user.current_ability_org_ids,'search[state_in]' => ['billed','loaded','shipped'])",
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :ship => {:title => "发车",:conditions =>"{:from_org_id => user.current_ability_org_ids,:state => 'loaded'}"},
        :destroy => {:title => "删除",:conditions =>"{:from_org_id => user.current_ability_org_ids}"}
      }
    }
    sf.update_by_hash(sf_hash)
  end
  end

  def down
  end
end
