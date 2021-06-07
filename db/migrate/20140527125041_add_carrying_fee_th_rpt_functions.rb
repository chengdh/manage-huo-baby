#coding: utf-8
#添加实提运费相关功能
class AddCarryingFeeThRptFunctions < ActiveRecord::Migration
  def up
    group_name = "查询统计"
    subject_title = "分理处实提运费表"
    subject = "CarryingFeeThRpt"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_fenlichu_carrying_fee_th_rpts_path',
      :subject => subject,
      :function => {
        :rpt_fenlichu => {:title => "分理处实提运费"},
        :fenlichu_export_excel => {:title => "导出"}
      }
    }

    sf = SystemFunction.find_by_subject_title(subject_title)
    SystemFunction.create_by_hash(sf_hash) if not sf

    subject_title = "分公司实提运费表"
    subject = "CarryingFeeThRpt"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'rpt_fengongsi_carrying_fee_th_rpts_path',
      :subject => subject,
      :function => {
        :rpt_fengongsi => {:title => "分公司实提运费"},
        :fengongsi_export_excel => {:title => "导出"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)

    SystemFunction.create_by_hash(sf_hash)  if not sf
  end

  def down
  end
end
