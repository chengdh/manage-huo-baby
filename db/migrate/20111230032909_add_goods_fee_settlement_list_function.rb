# -*- encoding : utf-8 -*-
#coding: utf-8
#添加分理处提款结算清单系统功能
class AddGoodsFeeSettlementListFunction < ActiveRecord::Migration
  def self.up
    #添加system_function
    group_name ="结算管理"
    ##################################通知消息设置###############################################
    subject_title = "分理处货款收支清单管理"
    subject = "GoodsFeeSettlementList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'goods_fee_settlement_lists_path("search[org_id_in]" => current_user.current_ability_org_ids,"search[state_eq]" => "draft")',
      :subject => subject,
      :function => {
      :read =>{:title => "查看"} ,
      :update =>{:title =>"修改",:conditions =>"{:state => 'draft',:org_id => user.current_ability_org_ids}"},
      :post =>{:title =>"确认",:conditions =>"{:state => 'draft',:org_id => user.current_ability_org_ids}"},
      :print =>{:title =>"打印",:conditions =>"{:state => 'posted'}"},
      :destroy => {:title => "删除"}
    }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def self.down
  end
end

