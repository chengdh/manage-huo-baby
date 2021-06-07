#coding: utf-8
#给分公司盘货单添加导出到excel功能
class AddExportExcelFunctionToYardInventory < ActiveRecord::Migration
  def change
    subject_title = "分公司盘货单(待确认)"
    subject = "YardInventory"
    sf_hash = {
      :subject_title => subject_title,
      :subject => subject,
      :function => {
        :export_sms_txt => {:title => "导出到货通知短信",:conditions => "{:state => ['shipped','checked','reached']}"}
      }
    }
    SystemFunction.generate_by_hash(sf_hash)
  end
end
