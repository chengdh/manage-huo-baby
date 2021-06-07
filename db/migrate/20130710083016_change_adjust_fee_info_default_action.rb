#coding: utf-8
#修改运费调整default_action
class ChangeAdjustFeeInfoDefaultAction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("运费调整")
    sf.update_attributes(:default_action => "adjust_fee_infos_path('search[state_ni]' => ['authorized','denied'])") if sf
  end

  def down
  end
end
