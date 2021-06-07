#coding: utf-8
class AddExportFunctionToPriceTable < ActiveRecord::Migration
  def change
    group_name = "查询统计"
    subject_title = "分公司运价参考表"
    subject = "PriceTable"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => "price_tables_path()",
      :subject => subject,
      :function => {
        :export_excel => {:title => "导出到excel"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?
  end
end
