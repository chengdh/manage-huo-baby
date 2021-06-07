#coding: utf-8
#同城快递-加条码打印功能
class AddPrintBarcode2LocalTownBill < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('同城-运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "LocalTownBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "LocalTownBill",
        :action => :print_barcode
      }

      sfo.save!
    end
    #手工运单录入
    sf = SystemFunction.find_by_subject_title('同城-手工运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "HandLocalTownBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "HandLocalTownBill",
        :action => :print_barcode
      }
      sfo.save!
    end

  end

  def down
  end
end
