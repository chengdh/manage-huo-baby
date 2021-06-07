#coding: utf-8
class AddExportExcelOnlyFromToInfoToCarryingBillsFunction < ActiveRecord::Migration
  def change
    subject_title = "运费/货款统计"
    subject = "CarryingBill"
    sf_hash = {
      :subject => subject,
      :function => {
        :export_excel_only_from_to_info => {:title => "导出发货人及收货人信息"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?
  end
end
