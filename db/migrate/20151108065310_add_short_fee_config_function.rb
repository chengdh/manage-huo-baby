#coding: utf-8
#添加到货短途费设置
class AddShortFeeConfigFunction < ActiveRecord::Migration
  def up
    group_name = "系统管理"
    subject_title = "到货短途费生成设置"
    subject = "ShortFeeConfig"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'short_fee_configs_path',
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
