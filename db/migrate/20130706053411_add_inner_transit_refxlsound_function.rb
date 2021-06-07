#coding: utf-8
#添加中转返款处理功能
class AddInnerTransitRefxlsoundFunction < ActiveRecord::Migration
  def up
    ##############################到货清单管理#############################################
    #NOTE 与load_list是相同的,不过仅仅重新派生了一个controller
    group_name = "内部中转业务"
    subject_title = "中转返款单"
    subject = "Refound"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'from_org_refunds_path',
      :subject => subject,
      :function => {
        :read_from_org =>{:title => "查看"} ,
        :create_from_org =>{:title => "新建"} ,
        :export_from_org => {:title => "导出"}
      }

    }
    SystemFunction.create_by_hash(sf_hash)

    #####################################中转到货###############################################
    subject_title = "中转返款单(总部处理)"
    subject = "Refound"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'transit_org_refunds_path',
      :subject => subject,
      :function => {
        #中转地查看
        :read_transit_org => {:title => "查看"} ,
        :confirm_transit_org => {:title => "中转确认",:conditions =>"{:state => 'refunded',:transit_org_id => user.current_ability_org_ids}"},
        :export_transit_org => {:title => "导出"},
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    #######################到货处理###########################
    subject_title = "中转返款单(收款处理)"
    subject = "Refound"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'to_org_refunds_path',
      :subject => subject,
      :function => {
        :read_to_org => {:title => "查看"} ,
        :confirm_to_org => {:title => "收款确认",:conditions =>"{:state => 'transit_refunded_confirmed',:to_org_id => user.current_ability_org_ids}"},
        :export_to_org => {:title => "导出"},
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
