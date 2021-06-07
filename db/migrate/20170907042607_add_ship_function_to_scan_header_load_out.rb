#coding: utf-8
class AddShipFunctionToScanHeaderLoadOut < ActiveRecord::Migration
  def change
    subject_title = "装卸组出库"
    subject = "ScanHeaderLoadOut"
    sf_hash = {
      :subject => subject,
      :function => {
        :ship => {:title => "发车",:conditions =>"{:state => 'loaded_out'}"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?
  end
end
