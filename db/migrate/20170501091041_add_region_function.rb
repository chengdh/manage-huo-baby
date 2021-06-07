#coding: utf-8
class AddRegionFunction < ActiveRecord::Migration
  def up
    group_name = "内部中转-分成设置"
    #################################理赔管理################################################
    subject_title = "区域设置"
    subject = "Region"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'regions_path()',
      :function => {
        :read => {:title => "查看"},
        :create => {:title => "新建"},
        :update => {:title => "修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
