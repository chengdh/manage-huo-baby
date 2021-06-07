#coding: utf-8
#监控扫码明细create
class LoadListWithBarcodeLineObserver < ActiveRecord::Observer
  observe :load_list_with_barcode_line
  def after_create(line)
    #更新carrying_bill_id
    bill_no = line.barcode[3,12]
    line.logger.debug("in LoadListWithBarcodeLineObserver bill_no = " + bill_no)
    carrying_bill = CarryingBill.select(:id).where(:bill_no => bill_no,:completed => false).first
    line.update_attributes(:carrying_bill_id => carrying_bill.id)
  end
end
