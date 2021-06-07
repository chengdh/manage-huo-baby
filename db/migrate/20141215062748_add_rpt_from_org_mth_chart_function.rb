#coding: utf-8
#添加营业分析图
class AddRptFromOrgMthChartFunction < ActiveRecord::Migration
  def change
    group_name = "查询统计"
    subject_title = "营业数据分析图"
    subject = "RptFromOrgMth"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      #默认不显示已确认的数据
      :default_action => 'rpt_from_org_mths_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end
end
