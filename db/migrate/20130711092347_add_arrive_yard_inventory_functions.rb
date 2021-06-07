#coding: utf-8
#添加分公司盘货单相关功能
class AddArriveYardInventoryFunctions < ActiveRecord::Migration
  def change 
    ######################货场盘货单增加发货功能################
    group_name = "盘货操作"
    subject_title = "货场盘货单"
    subject = "YardInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :function => {
        :ship => {:title => "发货",:conditions => "{:state => 'billed',:from_org_id => current_ability_org_ids}"},
      }
    }
    SystemFunction.generate_by_hash(sf_hash)

    ##############################到货清单管理#############################################
    group_name = "盘货操作"
    subject_title = "分公司盘货单(待确认)"
    subject = "YardInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'arrive_yard_inventories_path("search[state_eq]" => "shipped","search[to_org_id_in]" => current_user.current_ability_org_ids)',
      :subject => subject,
      :function => {
        :read_arrive => {:title => "查看",:conditions => "{:state => ['shipped','checked','reached'],:to_org_id => current_ability_org_ids}"},
        :check =>{:title => "到货检查",:conditions => "{:state => 'shipped',:to_org_id => current_ability_org_ids}"},
        :reach =>{:title => "盘货确认",:conditions => "{:state => 'checked',:to_org_id => current_ability_org_ids}"}
      }
    }
    SystemFunction.generate_by_hash(sf_hash)
  end
end
