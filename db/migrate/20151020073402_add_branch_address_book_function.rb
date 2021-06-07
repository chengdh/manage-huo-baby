#coding: utf-8
#添加分理处 分公司 科室通讯录
class AddBranchAddressBookFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("通讯录")
    if sf.present?
      sf.update_attributes(:subject_title => "分理处通讯录",:default_action => "address_books_path('search[tag_eq]' => 'address_book_tag_department')")
    end
  end

  def down
  end
end
