#coding: utf-8
#月结/回付客户付款记录功能
class AddCustomerPaymentInfoFunction < ActiveRecord::Migration
  def up
    group_name = "结算管理"
    subject_title = "月结/回付客户付款管理"
    subject = "CustomerPaymentInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => "customer_payment_infos_path",
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :confirm => {:title => "收款确认",:conditions =>"{:state => 'customer_paid' }"},
        :destroy =>{:title => "删除",:conditions =>"{:from_org_id => user.current_ability_org_ids }"} ,
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
