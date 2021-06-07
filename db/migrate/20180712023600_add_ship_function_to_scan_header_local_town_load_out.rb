#coding: utf-8
class AddShipFunctionToScanHeaderLocalTownLoadOut < ActiveRecord::Migration
  def change
    subject_title = "同城快运-装卸组出库单"
    subject = "ScanHeaderLocalTownLoadOut"
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
