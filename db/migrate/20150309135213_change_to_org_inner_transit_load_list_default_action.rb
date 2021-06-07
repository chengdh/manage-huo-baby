#coding: utf-8
class ChangeToOrgInnerTransitLoadListDefaultAction < ActiveRecord::Migration
  def up
    subject_title = "中转到货处理"
    subject = "InnerTransitLoadList"
    group_name = "内部中转业务"

    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf
      sf.update_attributes(:default_action => 'to_org_inner_transit_load_lists_path("search[state_eq]" => "transit_shipped")')
    end
  end

  def down
  end
end
