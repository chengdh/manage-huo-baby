#coding: utf-8
#添加导出客户信息功能
class AddExportExcelFunctionToImportedCustomer < ActiveRecord::Migration
  def change
    sf = SystemFunction.find_by_subject_title('客户分级')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('导出到excel')
      function_obj = {
        :subject => "ImportedCustomer",
        :action => :export_excel
      }
      sfo.function_obj = function_obj
      sfo.new_function_obj = function_obj
      sfo.save!
    end
  end
end
