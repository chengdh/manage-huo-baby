# -*- encoding : utf-8 -*-
#coding: utf-8
class ModifyTurnonverChartFunction < ActiveRecord::Migration
  def self.up
    #修改日营业额统计图的default_action
    sf = SystemFunction.find_by_subject_title('日营业额统计图')
    sf.update_attributes(:default_action =>  'turnover_chart_carrying_bills_path("search[type_in]" => ["ComputerBill","TransitBill","HandTransitBill","HandBill","ReturnBill"],"search[bill_date_gte]" => Date.today.beginning_of_day,"search[bill_date_lte]" => Date.today.end_of_day)') if sf.present?
    #添加理赔修改功能
    sf = SystemFunction.find_by_subject_title('货损理赔')
    func_obj =  {
      :subject => "GoodsException",
      :action => :update_with_submited,
      :conditions => "{:state => 'submited' }"}

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("修改")
      ops.update_attributes(:function_obj => func_obj)
    end
  end

  def self.down
  end
end

