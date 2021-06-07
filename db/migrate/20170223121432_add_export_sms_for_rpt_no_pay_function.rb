#coding: utf-8
class AddExportSmsForRptNoPayFunction < ActiveRecord::Migration
  def up

    sf = SystemFunction.find_by_subject_title('提货未提款统计')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('导出货款提取短信群发文件')
      sfo.function_obj = sfo.new_function_obj = {
        :subject => "CarryingBill",
        :action => :export_sms_txt_for_rpt_no_pay
      }
      sfo.save!
    end
  end

  def down
  end
end
