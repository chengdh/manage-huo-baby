#coding: utf-8
#从未提货报表生成到货通知清单
class AddBuildNoticeFromRptNoDeliveryFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('本地未提货统计')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('生成到货通知清单')
      sfo.function_obj = sfo.new_function_obj = {
        :subject => "CarryingBill",
        :action => :build_notice
      }

      sfo.save!
      sfo = sf.system_function_operates.find_or_create_by_name('生成到货通知短信文件')
      sfo.function_obj = sfo.new_function_obj = {
        :subject => "CarryingBill",
        :action => :export_sms_txt
      }
      sfo.save!

    end
  end
  def down
   sf = SystemFunction.find_by_subject_title('本地未提货统计')
    if sf
      sfo = sf.system_function_operates.find_by_name('生成到货通知清单')
      sfo.destroy if sfo
      sfo = sf.system_function_operates.find_by_name('生成到货通知短信文件')
      sfo.destroy if sfo
    end
  end
end
