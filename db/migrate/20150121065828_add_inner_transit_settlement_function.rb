#coding: utf-8
#添加内部中转 结算员交款清单功能
class AddInnerTransitSettlementFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    subject_title = "内部中转-结算员交款清单"
    subject = "InnerTransitSettlement"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      #默认不显示已确认的数据
      :default_action => 'can?(:create,InnerTransitSettlement) ? new_inner_transit_settlement_path : inner_transit_settlements_path("search[state_eq]" => "settlemented")',
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
