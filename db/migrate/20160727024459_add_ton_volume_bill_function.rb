#coding: utf-8
class AddTonVolumeBillFunction < ActiveRecord::Migration
  def up
    #配送管理模块
    group_name = "配送管理"
    #################################运单录入################################################
    subject_title = "机打运单-按照吨/方计费"
    subject = "TonVolumeBill"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'can?(:create,TonVolumeBill) ? new_ton_volume_bill_path : ton_volume_bills_path("search[from_org_id_in]" => current_user.current_ability_org_ids,"search[completed_eq]" => 0,"search[bill_date_eq]" => Date.today,:sort => "carrying_bills.bill_date desc,goods_no",:direction => "asc")',
      :function => {
        #查看相关运单,其他机构发往当前用户机构的运单
        :create => {:title => "新建"},
        :update_all =>{:title =>"修改",:conditions =>"{:state => ['loaded','billed'],:from_org_id => user.current_ability_org_ids}"},
        :destroy => {:title => "删除",:conditions =>"{:state => ['loaded','billed'],:from_org_id => user.current_ability_org_ids}"},
        :print => {:title => "票据打印",:conditions =>"{:state => 'billed'}"},
        :invalidate => {:title => "票据作废",:conditions =>"{:state => 'billed'}"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
    sf = SystemFunction.find_by_subject_title('机打运单-按照吨/方计费')
    sf.destroy if sf
  end
end
