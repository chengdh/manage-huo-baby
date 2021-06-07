#coding: utf-8
#添加分公司通讯录
class AddFengongsiAddressBookFunction < ActiveRecord::Migration
  def up
    group_name = "查询统计"
    subject_title = "分公司通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path("search[tag_eq]" => "address_book_tag_branch")',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

    subject_title = "科室通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path("search[tag_eq]" => "address_book_tag_other")',
      :subject => subject,
      :function => {
        :read => {:title => "查看"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
