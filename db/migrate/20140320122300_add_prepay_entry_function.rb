#coding: utf-8
#创建预付款凭证功能项
class AddPrepayEntryFunction < ActiveRecord::Migration
  def up
    group_name="结算管理"
    ##############################货物运输清单管理#############################################
    subject_title = "预付款凭证"
    subject = "PrepayEntry"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'prepay_entries_path("search[bill_date_gte]" => Date.today)',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash) unless SystemFunction.exists?(:subject_title => subject_title)
  end

  def down
  end
end
