#coding: utf-8
#添加负责人 介绍
class AddLeaderToAddressBook < ActiveRecord::Migration
  def change
    add_column :address_books,:leader,:string,:limit => 30
    add_column :address_books,:note,:text
    add_column :address_books,:tag,:string,:limit => 40
  end
end
