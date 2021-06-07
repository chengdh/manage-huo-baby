#coding: utf-8
class AddBranchCustomerFunction < ActiveRecord::Migration
  def up
    group_name = "客户关系管理"
    subject_title = "客户资料-分支机构"
    subject = "BranchCustomer"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'branch_customers_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改",:conditions =>"{:org_id => user.current_ability_org_ids }"},
        :destroy => {:title => "删除",:conditions =>"{:org_id => user.current_ability_org_ids }"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
