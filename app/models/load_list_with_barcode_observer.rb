#coding: utf-8
#监控扫码数据上传操作
class LoadListWithBarcodeObserver < ActiveRecord::Observer
  observe :load_list_with_barcode
  def after_save(ll_with_barcode)
    LoadListWithBarcode.generate_inventory(ll_with_barcode.bill_date,ll_with_barcode.from_org_id,ll_with_barcode.to_org_id,ll_with_barcode.op_type)
  end
end
