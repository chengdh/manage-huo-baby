#coding: utf-8
class ChangeToOrgInnerTransitLoadListFunction < ActiveRecord::Migration
  def up
    subject_title = "中转到货处理"
    subject = "InnerTransitLoadList"
    group_name = "内部中转业务"

    sf = SystemFunction.find_by_subject_title(subject_title)
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'to_org_inner_transit_load_lists_path',
      :subject => subject,
      :function => {
        :read_to_org => {:title => "查看"} ,
        :reach_to_org => {:title => "到货确认",:conditions =>"{:state => 'transit_shipped',:to_org_id => user.current_ability_org_ids}"},
        :export_to_org => {:title => "导出"},
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
