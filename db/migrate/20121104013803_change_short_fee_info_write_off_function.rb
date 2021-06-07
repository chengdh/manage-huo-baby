#coding: utf-8
class ChangeShortFeeInfoWriteOffFunction < ActiveRecord::Migration
  def up
    #添加短途运费核销功能
    sf = SystemFunction.find_by_subject_title('短途运费管理')
    func_obj =  {
      :subject => "ShortFeeInfo",
      :action => :write_off,
      :conditions =>"{:state => 'saved'}"
    }

    if sf
      sf.update_attributes(:default_action => "short_fee_infos_path('search[state_eq]' => 'saved')")
      ops = sf.system_function_operates.find_or_create_by_name("核销短途运费信息")
      ops.update_attributes(:new_function_obj => func_obj,:function_obj => func_obj)
    end
  end

  def down
    sf = SystemFunction.find_by_subject_title('短途运费管理')
    if sf
      ops = sf.system_function_operates.find_by_name("核销短途运费信息")
      ops.destroy if ops
    end
  end
end
