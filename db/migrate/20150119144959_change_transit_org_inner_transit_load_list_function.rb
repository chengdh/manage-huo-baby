#coding: utf-8
class ChangeTransitOrgInnerTransitLoadListFunction < ActiveRecord::Migration
  def up
    subject_title = "到货清单中转处理"
    sf = SystemFunction.find_by_subject_title(subject_title)
    group_name = "内部中转业务"
    subject = "InnerTransitLoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'transit_org_inner_transit_load_lists_path',
      :subject => subject,
      :function => {
        #中转地查看
        :read_transit_org => {:title => "查看"} ,
        :reach_transit_org => {:title => "中转确认",:conditions =>"{:state => 'shipped',:transit_org_id => user.current_ability_org_ids}"},
        :ship_transit_org => {:title => "中转发货",:conditions =>"{:state => 'transit_reached',:transit_org_id => user.current_ability_org_ids}"},
        :export_transit_org => {:title => "导出"},
      }
    }

    sf.update_by_hash(sf_hash) if sf.present?

  end

  def down
  end
end
