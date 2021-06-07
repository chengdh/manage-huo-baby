#coding: utf-8
class ChangeTransitOrgInnerTransitBillLoadListFunction < ActiveRecord::Migration
  def up
    subject_title = "到货清单中转处理"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      sf.update_attributes(:default_action => 'transit_org_inner_transit_load_lists_path("search[state_ne]" => "reached")')
    end
  end
  def down
  end
end
