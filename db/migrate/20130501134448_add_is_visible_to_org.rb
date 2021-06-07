#coding: utf-8
#给org添加是否显示字段,该字段用于处理以下情况
#机构已撤销is_active = false,不允许录入新的票据,但是用户还可登录处理旧票据
class AddIsVisibleToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :is_visible, :boolean,:default => true,:null => false
  end
end
