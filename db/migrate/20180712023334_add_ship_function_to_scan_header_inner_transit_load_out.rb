#coding: utf-8
class AddShipFunctionToScanHeaderInnerTransitLoadOut < ActiveRecord::Migration
  def change
    subject_title = "内部中转-装卸组出库单"
    subject = "ScanHeaderInnerTransitLoadOut"
    sf_hash = {
      :subject => subject,
      :function => {
        :ship => {:title => "发车",:conditions =>"{:state => 'inner_transit_loaded_out'}"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?
  end
end
