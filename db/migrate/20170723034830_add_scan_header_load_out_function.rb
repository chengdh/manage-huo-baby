#coding: utf-8
class AddScanHeaderLoadOutFunction < ActiveRecord::Migration
  def up
    group_name = "分拣及装车"
    subject_title = "装卸组出库"
    subject = "ScanHeaderLoadOut"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'scan_header_load_outs_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :edit =>{:title =>"修改"},
        :destroy => {:title => "删除"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
