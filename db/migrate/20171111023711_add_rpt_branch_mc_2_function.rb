#coding: utf-8
class AddRptBranchMc2Function < ActiveRecord::Migration
  def up
    group_name = "分公司风险管控"
    subject_title = "预付分公司管控"
    subject = "CarryingBill"

    default_action = 'rpt_branch_mc_2_carrying_bills_path(:rpt_type => "rpt_branch_mc_2")'
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => default_action,
      :subject => subject,
      :function => {
        :rpt_branch_mc_2=>{:title =>"预付分公司管控"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)

  end

  def down
  end
end
