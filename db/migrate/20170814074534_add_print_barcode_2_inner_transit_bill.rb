#coding: utf-8
class AddPrintBarcode2InnerTransitBill < ActiveRecord::Migration
  def up
    #机打运单
    sf = SystemFunction.find_by_subject_title('内部中转运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "InnerTransitBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "InnerTransitBill",
        :action => :print_barcode
      }

      sfo.save!
    end
    #手工运单录入
    sf = SystemFunction.find_by_subject_title('内部中转运单(手工)')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "HandInnerTransitBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "HandInnerTransitBill",
        :action => :print_barcode
      }
      sfo.save!
    end

  end

  def down
  end
end
