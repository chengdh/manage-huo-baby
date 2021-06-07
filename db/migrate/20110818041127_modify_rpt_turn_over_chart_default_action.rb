# -*- encoding : utf-8 -*-
#coding: utf-8
class ModifyRptTurnOverChartDefaultAction < ActiveRecord::Migration
  def self.up
    #修改日营业额统计图的默认菜单url
    sf = SystemFunction.find_by_subject_title('日营业额统计图')
    sf.update_attributes(:default_action => 'turnover_chart_carrying_bills_path("search[type_in]" => ["ComputerBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day,"search[from_org_id_eq]" => current_user.default_org_id)') if sf.present?
  end

  def self.down
  end
end

