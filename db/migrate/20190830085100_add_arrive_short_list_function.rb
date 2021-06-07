#coding: utf-8
#短驳单到货处理
class AddArriveShortListFunction < ActiveRecord::Migration
  def up
    group_name = "短驳业务"
    subject_title = "短驳到货处理"
    subject = "ShortList"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'arrive_short_lists_path("search[state_eq]" => "shipped")',
      :subject => subject,
      :function => {
        :read_arrive =>{:title => "查看",:conditions =>"{:state => ['shipped','reached'],:to_org_id => user.current_ability_org_ids}"} ,
        :export => {:title => "导出"},
        :reach => {:title => "到货确认",:conditions =>"{:state => 'shipped',:to_org_id => user.current_ability_org_ids}"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
