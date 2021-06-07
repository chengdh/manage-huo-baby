#coding: utf-8
#添加运费调整功能
class AddAdjustFeeInfoFunctions < ActiveRecord::Migration
  def up
    group_name = "理赔管理"
    subject_title = "运费调整"
    subject = "AdjustFeeInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'adjust_fee_infos_path',
      :subject => subject,
      :function => {
        :read => {:title => "查看"},
        :create => {:title => "新建"} ,
        :update =>{:title =>"修改", :conditions =>"{:state => ['submited','denied'],:org_id => user.current_ability_org_ids}"},
        :destroy =>{:title =>"删除",:conditions =>"{:state => ['submited','denied'],:org_id => user.current_ability_org_ids}"},
        :pass => {:title => "审批",:conditions =>"{:state => ['submited'],:op_org_id => user.current_ability_org_ids}"},
        :deny => {:title => "驳回",:conditions =>"{:state => ['submited'],:op_org_id => user.current_ability_org_ids}"},
        :re_submit => {:title => "重新上报",:conditions =>"{:state => 'denied',:org_id => user.current_ability_org_ids}"},
        :export_excel => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
