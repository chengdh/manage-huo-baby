#coding: utf-8
#重新添加条码打印功能
#NOTE merge upgrade_to_rails32后,出现conflict
class ReAddPrintBarcodeFunction < ActiveRecord::Migration
  def up
    #机打运单
    sf = SystemFunction.find_by_subject_title('机打运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "ComputerBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "ComputerBill",
        :action => :print_barcode
      }

      sfo.save!
    end
    #手工运单录入
    sf = SystemFunction.find_by_subject_title('手工运单录入')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "HandBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "HandBill",
        :action => :print_barcode
      }

      sfo.save!
    end

    #机打运单-自动计算运费
    sf = SystemFunction.find_by_subject_title('机打运单-自动计算运费')
    if sf
      sfo = sf.system_function_operates.find_or_create_by_name('打印条码')
      sfo.function_obj = {
        :subject => "AutoCalculateComputerBill",
        :action => :print_barcode
      }
      sfo.new_function_obj = {
        :subject => "AutoCalculateComputerBill",
        :action => :print_barcode
      }

      sfo.save!
    end

  end

  def down
  end
end
