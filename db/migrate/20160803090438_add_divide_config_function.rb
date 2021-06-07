#coding: utf-8
class AddDivideConfigFunction < ActiveRecord::Migration
  def up
    group_name ="运费分成设置"
    subject_title = "票据分成设置"
    subject = "DivideConfig"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'divide_configs_path',
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
