#coding: utf-8
class ChangeRptDivideFunction < ActiveRecord::Migration
  def up
    group_name= '分成报表'
    subject_title = "分公司运费分成报表"
    sfg = SystemFunctionGroup.find_by_name(group_name)
    sf = SystemFunction.find_by_subject_title("运费分成报表")
    if sf.present?
      sf.update_attributes(:subject_title => subject_title,:system_function_group => sfg)
    end
  end

  def down
  end
end
