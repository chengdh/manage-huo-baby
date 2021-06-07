#coding: utf-8
#内部中转-装卸组入库
class AddInnerTransitLoadInFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转业务"
    #################################分理处/分公司管理################################################
    subject_title = "内部中转-装卸组入库"
    subject = "ScanHeaderInnerTransitLoadIn"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'scan_header_inner_transit_load_ins_path',
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
