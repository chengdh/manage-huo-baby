#coding: utf-8
#添加导出到excel功能
class AddExportExcelFunctionForAddressBook < ActiveRecord::Migration
  def up
    group_name = "通讯录"
    subject_title = "分理处通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => "address_books_path('search[tag_eq]' => 'address_book_tag_department')",
      :subject => subject,
      :function => {
        :export_excel => {:title => "导出到excel"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?

    ##########分公司通讯录###############
    group_name = "通讯录"
    subject_title = "分公司通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path("search[tag_eq]" => "address_book_tag_branch")',
      :subject => subject,
      :function => {
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"},
        :export_excel => {:title => "导出到excel"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?

    ##########科室通讯录###############
    group_name = "通讯录"
    subject_title = "科室通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path("search[tag_eq]" => "address_book_tag_other")',
      :subject => subject,
      :function => {
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"},
        :export_excel => {:title => "导出到excel"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?

    ##########装卸组通讯录###############
    group_name = "通讯录"
    subject_title = "装卸组通讯录"
    subject = "AddressBook"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'address_books_path("search[tag_eq]" => "address_book_tag_load")',
      :subject => subject,
      :function => {
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"},
        :export_excel => {:title => "导出到excel"}
      }
    }
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
