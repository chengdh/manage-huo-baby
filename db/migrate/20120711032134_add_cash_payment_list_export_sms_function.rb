#coding: utf-8
class AddCashPaymentListExportSmsFunction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title('现金-代收货款支付')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('生成短信通知文件')
      sfo.function_obj = {
        :subject => "CashPaymentList",
        :action => :export_sms_txt
      }
      sfo.save!
    end
  end
end
