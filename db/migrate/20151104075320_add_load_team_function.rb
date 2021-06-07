#coding: utf-8
class AddLoadTeamFunction < ActiveRecord::Migration
  def up
    group_name = "通讯录"
    subject_title = "装卸组通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path("search[tag_eq]" => "address_book_tag_load")',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"}
      }
    }

    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
