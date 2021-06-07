#coding: utf-8
class AddScanHeaderTeamFunction < ActiveRecord::Migration
  def up
    group_name = "分拣及装车"
    #################################分理处/分公司管理################################################
    subject_title = "装卸工作量统计"
    subject = "ScanHeaderTeam"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'scan_header_teams_path',
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
