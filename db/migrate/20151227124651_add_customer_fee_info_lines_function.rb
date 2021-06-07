#coding: utf-8
class AddCustomerFeeInfoLinesFunction < ActiveRecord::Migration
  def up
    ##############################客户运费统计#################################################
    group_name = "客户关系管理"
    subject_title = "客户运费统计"
    subject = "CustomerFeeInfoLine"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :default_action => 'customer_fee_info_lines_path("search[customer_fee_info_org_id_in]" => current_user.current_ability_org_ids,"search[customer_fee_info_mth_eq]" => Date.today.strftime("%Y%m"))',
      :function => {
        :read => {:title => "查看"},
        :export => {:title => "导出"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
