#coding: utf-8
#修改字段,使其可以为null
class ChangeColumnsFromActLoadList < ActiveRecord::Migration
  def up
    change_column :act_load_lists,:load_list_id,:integer,:null => true
    change_column :act_load_lists,:to_org_id,:integer,:null => true
  end

  def down
  end
end
