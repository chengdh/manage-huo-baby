#coding: utf-8
#中转到货单管理
class AddTransitLoadListFunction < ActiveRecord::Migration
  def up
    ##############################到货清单管理#############################################
    #NOTE 与load_list是相同的,不过仅仅重新派生了一个controller
    group_name = "内部中转业务"
    subject_title = "内部中转清单"
    subject = "LoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'transit_load_lists_path',
      :subject => subject,
      :function => {
        #中转地查看
        :create_transit => {:title => "新建"},
        :read_from_org => {:title => "查看"} ,
        :ship_from_org => {:title => "发车",:conditions =>"{:state => 'billed',:from_org_id => user.current_ability_org_ids}"},
        :export_from_org => {:title => "导出"},
      }
    }
    SystemFunction.create_by_hash(sf_hash)

    #####################################中转到货###############################################
    subject_title = "到货清单中转处理"
    subject = "LoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'transit_org_load_lists_path',
      :subject => subject,
      :function => {
        #中转地查看
        :read_transit_org => {:title => "查看"} ,
        :reach_transit_org => {:title => "中转确认",:conditions =>"{:state => 'shipped',:transit_org_id => user.current_ability_org_ids}"},
        :ship_transit_org => {:title => "中转发货",:conditions =>"{:state => 'transit_reached',:transit_org_id => user.current_ability_org_ids}"},
        :export_transit_org => {:title => "导出"},
      }
    }
    SystemFunction.create_by_hash(sf_hash)
    #######################到货处理###########################
    subject_title = "中转到货处理"
    subject = "LoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'to_org_load_lists_path',
      :subject => subject,
      :function => {
        :read_to_org => {:title => "查看"} ,
        :reach_to_org => {:title => "到货确认",:conditions =>"{:state => 'transit_shipped',:to_org_id => user.current_ability_org_ids}"},
        :export_to_org => {:title => "导出"},
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
