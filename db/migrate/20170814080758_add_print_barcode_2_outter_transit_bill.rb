#coding: utf-8
#外部中转-添加条码打印功能
class AddPrintBarcode2OutterTransitBill < ActiveRecord::Migration
  def up
    #机打运单
    sf = SystemFunction.find_by_subject_title('中转运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "TransitBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "TransitBill",
        :action => :print_barcode
      }

      sfo.save!
    end
    #手工运单录入
    sf = SystemFunction.find_by_subject_title('手工中转运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "HandTransitBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "HandTransitBill",
        :action => :print_barcode
      }
      sfo.save!
    end

  end

  def down
  end
end
