#coding: utf-8
class AddScanHeaderLocalTownLoadInFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"

    subject_title = "同城快运-装卸组入库单"
    subject = "ScanHeaderLocalTownLoadIn"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'scan_header_local_town_load_ins_path',
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
