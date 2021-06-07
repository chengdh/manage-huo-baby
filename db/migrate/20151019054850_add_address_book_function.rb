#coding: utf-8
class AddAddressBookFunction < ActiveRecord::Migration
  def up
    group_name = "查询统计"
    subject_title = "通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path',
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
