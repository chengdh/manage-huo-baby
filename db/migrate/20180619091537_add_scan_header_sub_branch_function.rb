#coding: utf-8
#分理处装车功能
class AddScanHeaderSubBranchFunction < ActiveRecord::Migration
  def up
    group_name = "分拣及装车"
    #################################分理处/分公司管理################################################
    subject_title = "分理处装车"
    subject = "ScanHeaderSubBranch"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'scan_header_sub_branches_path',
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
