# -*- encoding : utf-8 -*-
#coding: utf-8
class AddUseUsbKeyToUser < ActiveRecord::Migration
  def self.up
    #添加使用usb标志和usb_pin
    add_column :users,:use_usb,:boolean,:default => false
    add_column :users,:usb_pin,:string,:limit => 32
  end

  def self.down
    remove_column :users,:use_usb
    remove_column :users,:usb_pin
  end
end

