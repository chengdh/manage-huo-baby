# -*- encoding : utf-8 -*-
#coding: utf-8
class AddIdNumberToSender < ActiveRecord::Migration
  def self.up
    #添加身份证号
    add_column :senders, :id_number, :string,:limit => 20
  end

  def self.down
    remove_column :senders, :id_number
  end
end

