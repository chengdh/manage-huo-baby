#coding: utf-8
#同城快运-结算员交款清单
class AddLocalTownSettlementFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-结算员交款清单"
    subject = "LocalTownSettlement"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      #默认不显示已确认的数据
      :default_action => 'can?(:create,LocalTownSettlement) ? new_local_town_settlement_path : local_town_settlements_path("search[state_eq]" => "settlemented")',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"},
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :settlement_confirm => {:title => "交款确认",:conditions => "{:org_id => user.current_ability_org_ids,:state => 'settlemented'}"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
