#coding: utf-8
class AddDeliverRegionsFunction < ActiveRecord::Migration
  def up
    group_name = "客户关系管理"
    subject_title = "送货区域管理"
    subject = "DeliverRegion"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'deliver_regions_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end
  def down
  end
end
