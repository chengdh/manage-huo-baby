#coding: utf-8
#修改到货清单中转处理的default_action
class ChangeTransitOrgLoadListFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('到货清单中转处理')
    sf.update_attributes(:default_action =>  'transit_org_load_lists_path("search[state_in]" => ["shipped","transit_reached"])') if sf

  end

  def down
  end
end
