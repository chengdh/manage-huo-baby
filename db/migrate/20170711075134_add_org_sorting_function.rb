#coding: utf-8
class AddOrgSortingFunction < ActiveRecord::Migration
  def up
    group_name = "基础信息管理"
    #################################分理处/分公司管理################################################
    subject_title = "分拣组管理"
    subject = "OrgSorting"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'org_sortings_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :edit =>{:title =>"修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
