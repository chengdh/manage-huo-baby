# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
class CreateOrgs < ActiveRecord::Migration
  def self.up
    create_table :orgs do |t|
      t.string :name,:null => false,:limit => 60
      t.string :simp_name,:limit => 20 #机构简称 
      t.integer :parent_id   #所属父机构id
      t.string :phone,:limit => 60        #联系电话
      t.boolean :is_active,:null => false ,:default => true
      t.string :manager,:limit => 20  #负责人
      t.string :location,:limit => 60  #地址
      t.string :code,:limit => 20  #机构编码
      t.string :lock_input_time,:limit => 20  #每日限制的停止录单时间
      t.string :type,:limit => 20 #记录类型 rails 使用,区分是科室还是分理处

      t.timestamps
    end
  end

  def self.down
    drop_table :orgs
  end
end

