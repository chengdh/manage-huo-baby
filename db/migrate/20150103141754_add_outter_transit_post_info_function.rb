#coding: utf-8
class AddOutterTransitPostInfoFunction < ActiveRecord::Migration
  def up
    group_name = "外部中转业务"
    subject_title = "外部中转-客户提款结算清单"
    subject = "OutterTransitPostInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'outter_transit_post_infos_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看",:conditions =>"{:org_id => user.current_ability_org_ids }"} ,
        :create => {:title => "新建"},
        :export => {:title => "导出"},
        :build_accounting_document => {:title => "生成凭证"},
        :batch_export_with_bank => {:title => "批量导出转账txt"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
