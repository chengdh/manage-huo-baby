#coding: utf-8
#同城快运业务
class AddArriveLocalTownLoadListFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-到货清单"
    subject = "LocalTownLoadList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'arrive_local_town_load_lists_path("search[state_eq]" => "shipped")',
      :subject => subject,
      :function => {
        :read_arrive =>{:title => "查看",:conditions =>"{:state => ['shipped','reached'],:to_org_id => user.current_ability_org_ids}"} ,
        :export => {:title => "导出"},
        :reach => {:title => "到货确认",:conditions =>"{:state => 'shipped',:to_org_id => user.current_ability_org_ids}"},
        :export_sms_text => {:title => "导出短信群发文件"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
