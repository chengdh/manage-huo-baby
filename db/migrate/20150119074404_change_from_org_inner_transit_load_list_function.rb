#coding: utf-8
#修改内部中中转-发货地相关功能
class ChangeFromOrgInnerTransitLoadListFunction < ActiveRecord::Migration
  def up
    old_subject_title = "内部中转清单"
    sf = SystemFunction.find_by_subject_title(old_subject_title)

    group_name = "内部中转业务"
    subject_title = "内部中转清单-发货"
    subject = "InnerTransitLoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'from_org_inner_transit_load_lists_path',
      :subject => subject,
      :function => {
        #中转地查看
        :create_transit => {:title => "新建"},
        :read_from_org => {:title => "查看"} ,
        :ship_from_org => {:title => "发车",:conditions =>"{:state => 'loaded',:from_org_id => user.current_ability_org_ids}"},
        :export_from_org => {:title => "导出"},
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
