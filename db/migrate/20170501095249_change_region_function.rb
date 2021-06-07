#coding: utf-8
class ChangeRegionFunction < ActiveRecord::Migration
  def up
    subject_title = "区域设置"
    sf = SystemFunction.find_by_subject_title("区域设置")
    sf_hash = {
      :subject_title => subject_title,
      :subject => "Region",
      :default_action => 'regions_path()',
      :function => {
        :read => {:title => "查看"},
        :create => {:title => "新建"},
        :update => {:title => "修改"},
        :destroy => {:title => "删除"}
      }
    }
    sf.update_by_hash(sf_hash) if sf.present?

  end

  def down
  end
end
