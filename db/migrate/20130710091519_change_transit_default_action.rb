#coding: utf-8
#修改中转相关的default_action功能
class ChangeTransitDefaultAction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('到货清单中转处理')
    sf.update_attributes(:default_action =>  'transit_org_load_lists_path("search[state_eq]" => "shipped")') if sf

    sf = SystemFunction.find_by_subject_title('中转到货处理')
    sf.update_attributes(:default_action =>  'to_org_load_lists_path("search[state_eq]" => "transit_shipped")') if sf

    sf = SystemFunction.find_by_subject_title('中转返款单(总部处理)')
    sf.update_attributes(:default_action =>  'transit_org_refunds_path("search[state_eq]" => "refunded")') if sf

    sf = SystemFunction.find_by_subject_title('中转返款单(收款处理)')
    sf.update_attributes(:subject_title => "中转收款处理",:default_action =>  'to_org_refunds_path("search[state_eq]" => "transit_refunded_confirmed")') if sf
  end

  def down
  end
end
