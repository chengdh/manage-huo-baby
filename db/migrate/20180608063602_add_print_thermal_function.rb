#coding: utf-8
#添加热敏票打印功能
class AddPrintThermalFunction < ActiveRecord::Migration
  def up
    group_name = "配送管理"
    sfg = SystemFunctionGroup.find_by_name(group_name)
    subject_title = "机打运单录入"
    sf = SystemFunction.find_by_subject_title_and_system_function_group_id(subject_title,sfg.id)
    if sf

      sfo_name = "打印热敏票"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "ComputerBill",
        :action => :print_thermal,
        :conditions =>"{:state => 'billed'}"
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end

    #自动计算运单
    subject_title = "机打运单-自动计算运费"
    sf = SystemFunction.find_by_subject_title_and_system_function_group_id(subject_title,sfg.id)
    if sf
      sfo_name = "打印热敏票"
      sfo = sf.system_function_operates.find_or_create_by_name(sfo_name)
      function_obj = {
        :subject => "AutoCalculateComputerBill",
        :action => :print_thermal,
        :conditions =>"{:state => 'billed'}"
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end
  end

  def down
  end
end
