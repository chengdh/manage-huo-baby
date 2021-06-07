#coding: utf-8
class AddArriveLoadListExportSmsTxtFunction < ActiveRecord::Migration
  def self.up
    sf = SystemFunction.find_by_subject_title('到货清单管理')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('导出短信群发文件')
      sfo.function_obj = {
        :subject => "LoadList",
        :action => :export_sms_txt
      }
      sfo.save!
    end
  end

  def self.down
  end
end
