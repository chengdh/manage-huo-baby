#coding: utf-8
#添加欠款提货清单相关功能
class AddDebtBillFunction < ActiveRecord::Migration
  def up
    group_name = "库存管理"
    #################################在库清单录入##################################
    subject_title = "欠款提货清单"
    subject = "DebtBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'debt_bills_path',
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改",:conditions =>"{:state => 'billed',:org_id => user.current_ability_org_ids}"},
        :destroy => {:title => "删除",:conditions =>"{:state => 'billed',:org_id => user.current_ability_org_ids}"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
