#coding: utf-8
class AddFromShortFeeInfoFunction < ActiveRecord::Migration
  def up
    group_name = "理赔管理"
    subject_title = "发货短途费申报"
    subject = "FromShortFeeInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => "from_short_fee_infos_path('search[from_org_id_or_to_org_id_in]' => current_user.current_ability_org_ids,:state => 'draft')",
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :destroy =>{:title => "删除",:conditions =>"{:from_org_id => user.current_ability_org_ids,:state => 'draft' }"} ,
        :pass =>{:title => "审批通过",:conditions =>"{:to_org_id => user.current_ability_org_ids,:state => 'draft' }"} ,
        :reject =>{:title => "驳回",:conditions =>"{:to_org_id => user.current_ability_org_ids,:state => 'draft' }"} ,
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
