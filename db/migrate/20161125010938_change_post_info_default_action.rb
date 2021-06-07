#coding: utf-8
class ChangePostInfoDefaultAction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title("客户提款结算清单")
    sf.update_attributes(:default_action => "post_infos_path('search[state_in]' => ['billed','posted'])") if sf
  end

  def down
  end
end
