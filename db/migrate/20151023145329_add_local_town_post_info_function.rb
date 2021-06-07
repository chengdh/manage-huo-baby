#coding: utf-8
#同城快运-客户提款结算清单
class AddLocalTownPostInfoFunction < ActiveRecord::Migration
  def up
    group_name = "同城快运业务"
    subject_title = "同城快运-客户提款结算清单"
    subject = "LocalTownPostInfo"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'local_town_post_infos_path',
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
