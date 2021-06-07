#coding: utf-8
#给users表添加token_aithorize字段
class AddTokenAuthorizeToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.token_authenticatable
    end
  end
end
