#coding: utf-8
#添加营业数据统计图-按照选定月份
class AddRptFromOrgMthWithSelectMthsFunction < ActiveRecord::Migration
  def change
    group_name = "查询统计"
    subject_title = "营业数据分析图-按月份"
    subject = "RptFromOrgMth"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'before_data_with_selected_mths_rpt_from_org_mths_path',
      :subject => subject,
      :function => {
        :before_data_with_selected_mths => {:title => "统计"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end
end
